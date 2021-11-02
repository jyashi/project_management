import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:path/path.dart' as p;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'nav_camera_page.dart';

navWriteToFile(
    {required fName,
    required String textMsg,
    FileMode fMode = FileMode.append}) async {
  if (await navCheckStoragePermission() == false) {
    return false;
  } else {
    final File file = File(p.join(await navGetDirectoryPath(), "$fName"));

    print("Successfully wrote to file: $fName");
    await file.writeAsString(textMsg, mode: fMode);
    await file.writeAsString("\n", mode: fMode);

    return true;
  }
}

Future<String> navReadFromFile({required String fName}) async {
  String textMsg;
  final File file = File(p.join(await navGetDirectoryPath(), "$fName"));
  if (await file.exists()) {
    textMsg = await file.readAsString();
    print("File $fName exists ------> $textMsg");
    return textMsg;
  } else {
    print("No such file exists...");
    return "";
  }
}

Future<String> navGetDirectoryPath() async {
  final Directory directory = await getApplicationDocumentsDirectory();

  return directory.path;
  // final File file = File(${directory.path)
}

navDeleteFile({required fName, required bool ARE_YOU_SURE}) async {
  // Need to add test if the file name to be deleted doesnt exist...
  if (ARE_YOU_SURE) {
    await File(p.join(await navGetDirectoryPath(), "$fName"))
        .delete(recursive: false);
    print("Deleted file $fName");
  }
}

Future<bool> navCheckStoragePermission() async {
  if (await Permission.storage.isGranted == true) {
    return true;
  } else {
    return false;
  }
}

Future<bool> navRequestStoragePermission() async {
  if (await Permission.storage.request().isGranted) {
    return true;
  }
  if (await Permission.storage.request().isPermanentlyDenied) {
    return false;
  }
  return false;
}

Future<bool> navRequestCameraPermission() async {
  if (await Permission.camera.request().isGranted) {
    print("Camera granted");
    return true;
  } else {
    await Permission.camera.request();
    navOpenAppSettings();
    print("Camera NOT granted");
    return false;
  }
}

navOpenAppSettings() {
  AppSettings.openAppSettings();
}
