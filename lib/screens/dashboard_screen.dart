// import 'package:flutter/material.dart';
// import '../controllers/dashboard_controller.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';

// class DashboardScreen extends StatelessWidget {
//   final DashboardController _controller = DashboardController();

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Dashboard"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               authProvider.logout();
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               _controller.getWelcomeMessage(),
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Center(
//               child: Image.asset(
//                 _controller.getImageUrl(),
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 16),
//             Center(
//               child: Text(
//                 'Welcome, ${authProvider.currentUser?.username ?? "Guest"}!',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
