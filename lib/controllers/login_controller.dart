// // lib/controllers/login_controller.dart

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import '/screens/dashboard_screen.dart';

// class LoginController {
//   // Handle login logic
//   Future<void> login(
//       BuildContext context, String usernameOrEmail, String password) async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);

//     // Validate fields
//     if (usernameOrEmail.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill in all fields')),
//       );
//       return;
//     }

//     // Call login method from authProvider
//     final success = await authProvider.login(usernameOrEmail, password);
//     if (success) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => DashboardScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Invalid credentials')),
//       );
//     }
//   }

//   // Handle password visibility toggle
//   void togglePasswordVisibility(VoidCallback updateVisibility) {
//     // Call the callback to toggle the password visibility in the screen
//     updateVisibility();
//   }
// }
