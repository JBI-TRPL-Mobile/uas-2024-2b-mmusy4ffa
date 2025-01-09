import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      print('Email atau password tidak boleh kosong');
    } else {
      print('Login berhasil dengan Email: $email dan Password: $password');
    }
  }
}
