import 'package:flutter/material.dart';
import 'package:flutter_application_1/diary_template.dart';
// import 'home_page.dart';
// import 'data_storage.dart';
// import 'nav_sempai_backend.dart';
import 'package:camera/camera.dart';
import 'package:flutter_application_1/home_page.dart';

List<CameraDescription> cameras = cameras;
Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(body: DiaryHomeScreen()),
    );
  }
}
