// import 'package:flutter/material.dart';
// import '../providers/auth_provider.dart';

// class RegisterController {
//   // Method to validate and handle the registration logic
//   Future<void> register(
//     BuildContext context,
//     String fullName,
//     String username,
//     String email,
//     String password,
//     String confirmPassword,
//     AuthProvider authProvider,
//   ) async {
//     // Validate if fields are not empty and passwords match
//     if (fullName.isEmpty ||
//         username.isEmpty ||
//         email.isEmpty ||
//         password.isEmpty ||
//         confirmPassword.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill in all fields')),
//       );
//       return;
//     }

//     if (password != confirmPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Passwords do not match')),
//       );
//       return;
//     }

//     // Call register method from authProvider
//     final success = await authProvider.register(username, password, email);

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Registration Successful')),
//       );
//       Navigator.pop(context); // Go back to the previous screen
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Username or Email already exists')),
//       );
//     }
//   }
// }
