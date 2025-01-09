import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';

class AuthController {
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/user_data.json';
    return File(path);
  }

  Future<List<dynamic>> _readJson() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        String contents = await file.readAsString();
        final data = json.decode(contents);
        return data['users'] ?? [];
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> _writeJson(List<dynamic> users) async {
    final file = await _getLocalFile();
    final data = json.encode({'users': users});
    await file.writeAsString(data);
  }

  Future<void> register(
    BuildContext context,
    String fullName,
    String username,
    String email,
    String password,
    String confirmPassword,
    AuthProvider authProvider,
  ) async {
    if (password != confirmPassword) {
      _showErrorDialog(context, 'Passwords do not match!');
      return;
    }

    List<dynamic> users = await _readJson();
    for (var user in users) {
      if (user['email'] == email || user['username'] == username) {
        _showErrorDialog(context, 'Email or username already taken!');
        return;
      }
    }

    users.add({
      'fullName': fullName,
      'username': username,
      'email': email,
      'password': password,
    });

    await _writeJson(users);

    _showSuccessDialog(context, 'Registration successful!');
  }

  Future<void> login(
    BuildContext context,
    String usernameOrEmail,
    String password,
    AuthProvider authProvider,
  ) async {
    List<dynamic> users = await _readJson();

    for (var user in users) {
      if ((user['email'] == usernameOrEmail ||
              user['username'] == usernameOrEmail) &&
          user['password'] == password) {
        authProvider.setUser(user);
        Navigator.pushReplacementNamed(context, '/dashboard');
        return;
      }
    }

    _showErrorDialog(context, 'Invalid username/email or password!');
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
