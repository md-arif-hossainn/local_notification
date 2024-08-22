import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home.dart';
import 'local_notifications.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await LocalNotifications.init();
//
//   if (Platform.isAndroid || Platform.isIOS) {
//     var status = await Permission.notification.status;
//     if (status.isDenied) {
//       await Permission.notification.request();
//     }
//   }
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

