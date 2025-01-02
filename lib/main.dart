import 'package:cat_control/Home.dart';
import 'package:cat_control/Mari.dart';
import 'package:cat_control/socket_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp( MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  DeviceOrientation.landscapeRight;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: 
    // MyApp(),
      Home(),
      // WebSocketDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}