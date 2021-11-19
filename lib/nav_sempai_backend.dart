import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:path/path.dart' as p;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'nav_camera_page.dart';
import 'package:image_picker/image_picker.dart';

/* 
- Writes string value to a text or JSON file. 
- Before writing checks if we have storage permission from user.
- Returns true if we do, false if we dont. 

Takes 2 parameters 
1. fName: which is the file name you want to save in 
2. textMsg: Which is the actual message you want to store in file.
*/
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

/*
- Reads data from a file located in default path.
- Returns the String variable if file exists 
- Returns empty string if file does not exist
Requires 1 parameter
1. fName : File name to read from
*/
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

/*
navGetDirectoryPath() 
Gets the default directory path from the device and returns it as string.
*/
Future<String> navGetDirectoryPath() async {
  final Directory directory = await getApplicationDocumentsDirectory();

  return directory.path;
  // final File file = File(${directory.path)
}

/*
navDeleteFile()
- Deletes the provided file.
Parameters required:
1. fName: The file to delete
2. ARE_YOU_SURE: A bool safety test to make sure the command isnt in error. 

*/
navDeleteFile({required fName, required bool ARE_YOU_SURE}) async {
  // Need to add test if the file name to be deleted doesnt exist...
  if (ARE_YOU_SURE) {
    await File(p.join(await navGetDirectoryPath(), "$fName"))
        .delete(recursive: false);
    print("Deleted file $fName");
  }
}

/*
navCheckStoragePermission()
Checks for Storage permission 
*/

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

class navOpenCamera extends StatefulWidget {
  const navOpenCamera({Key? key}) : super(key: key);

  @override
  _navOpenCameraState createState() => _navOpenCameraState();
}

class _navOpenCameraState extends State<navOpenCamera> {
  @override
  Widget build(BuildContext context) {
    print("BUILD DID FIRE");
    Future accessCamera() async {
      XFile? cameraFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front);

      setState(() {
        var _cameraFile = cameraFile;
      });
      return cameraFile;
    }

    return new Container();
  }
}

class navShowImage extends StatefulWidget {
  const navShowImage({Key? key}) : super(key: key);

  @override
  _navShowImageState createState() => _navShowImageState();
}

class _navShowImageState extends State<navShowImage> {
  late File image;

  @override
  Widget build(BuildContext context) {
    print("Picking from camera");
    Future accessGallery() async {
      final XFile? img = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      setState(() {
        var image = img;
      });
      return image;
    }

    return Scaffold(
      body: image == null ? Text('No Image Showing') : Image.file(image),
    );
  }
}

class navImageClass extends StatefulWidget {
  const navImageClass({Key? key}) : super(key: key);

  @override
  _navImageClassState createState() => _navImageClassState();
}

class _navImageClassState extends State<navImageClass> {
  late XFile? imageFile;

  navTakePicture() async {
    var img = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    this.setState(() {
      imageFile = img;
      print(img?.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
