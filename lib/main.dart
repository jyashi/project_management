import 'package:flutter/material.dart';
import 'home_page.dart';
import 'data_storage.dart';
import 'nav_sempai_backend.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyScaffold());
  // runApp(
  //   MaterialApp(
  //     theme: ThemeData.dark(),
  //     home: TakePictureScreen(
  //       // Pass the appropriate camera to the TakePictureScreen widget.
  //       camera: firstCamera,
  //     ),
  //   ),
  // );
}
