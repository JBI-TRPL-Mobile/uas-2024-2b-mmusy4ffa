import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';

class AuthController {
  // Fungsi untuk mendapatkan lokasi direktori penyimpanan aplikasi
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/user_data.json';
    return File(path);
  }

  // Fungsi untuk membaca data JSON dari file
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

  // Fungsi untuk menyimpan data pengguna ke dalam file JSON
  Future<void> _writeJson(List<dynamic> users) async {
    final file = await _getLocalFile();
    final data = json.encode({'users': users});
    await file.writeAsString(data);
  }

  // Fungsi untuk melakukan registrasi
  Future<void> register(
    BuildContext context,
    String fullName,
    String username,
    String email,
    String password,
    String confirmPassword,
    AuthProvider authProvider,
  ) async {
    // Validasi password dan konfirmasi password
    if (password != confirmPassword) {
      _showErrorDialog(context, 'Passwords do not match!');
      return;
    }

    // Ambil data pengguna yang sudah ada
    List<dynamic> users = await _readJson();

    // Cek apakah username atau email sudah terdaftar
    for (var user in users) {
      if (user['email'] == email || user['username'] == username) {
        _showErrorDialog(context, 'Email or username already taken!');
        return;
      }
    }

    // Tambahkan pengguna baru ke daftar
    users.add({
      'fullName': fullName,
      'username': username,
      'email': email,
      'password': password,
    });

    // Simpan data pengguna yang baru ke file JSON
    await _writeJson(users);

    // Menampilkan sukses atau lanjut ke login
    _showSuccessDialog(context, 'Registration successful!');
  }

  // Fungsi untuk login
  Future<void> login(
    BuildContext context,
    String usernameOrEmail,
    String password,
    AuthProvider authProvider,
  ) async {
    // Ambil data pengguna yang sudah ada
    List<dynamic> users = await _readJson();

    // Cari user berdasarkan username/email dan password
    for (var user in users) {
      if ((user['email'] == usernameOrEmail ||
              user['username'] == usernameOrEmail) &&
          user['password'] == password) {
        // Menyimpan status login pada provider (seperti AuthProvider)
        authProvider.setUser(user);
        Navigator.pushReplacementNamed(context, '/dashboard');
        return;
      }
    }

    // Jika tidak ditemukan, tampilkan error
    _showErrorDialog(context, 'Invalid username/email or password!');
  }

  // Fungsi untuk menampilkan dialog error
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

  // Fungsi untuk menampilkan dialog sukses
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
