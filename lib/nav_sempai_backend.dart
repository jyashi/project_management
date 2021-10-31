import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:path/path.dart' as p;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


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

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    print("Triggered here");
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}

openCamera() async {
  print("Triggered");
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
}
