import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:path/path.dart' as p;

navWriteToFile({required String fName, required String textMsg}) async {
  if (await navCheckStoragePermission() == false) {
    return false;
  } else {
    final File file = File(p.join("$navGetDirectoryPath", "myFile.txt"));
    await file.writeAsString(textMsg);
    return true;
  }
}

Future<String> navReadFromFile() async {
  String textMsg;
  final File file = File("$navGetDirectoryPath/myFile.txt");
  textMsg = await file.readAsString();
  return textMsg;
}

Future<String> navGetDirectoryPath() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  return directory.path;
  // final File file = File(${directory.path)
}

Future<bool> navCheckStoragePermission() async {
  if (await Permission.storage.isGranted == true) {
    return true;
  } else {
    return false;
  }
}

Future<bool> navRequestStoragePermission({bool openSettings = false}) async {
  if (await Permission.storage.request().isGranted) {
    return true;
  }
  if (await Permission.storage.request().isPermanentlyDenied) {
    return false;
  }
  return false;
}

navOpenAppSettings() {
  AppSettings.openAppSettings();
}
