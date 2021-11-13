import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:path/path.dart' as p;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
    return Column(children: <Widget>[
      Expanded(
        child: Scaffold(
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
                String pathName = "/Users/iosdev/Downloads/myImg.jpeg";

                // Attempt to take a picture and get the file `image`
                // where it was saved.
                final image = await _controller.takePicture();
                await image.saveTo(pathName);
                // storeImage(ImagePath: image.path);
                // print("Printing path : ");
                // print(image.path);
                // print(image.path.runtimeType);
                // If the picture was taken, display it on a new screen.
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      // Pass the automatically generated path to
                      // the DisplayPictureScreen widget.
                      // imagePath: image.path,
                      imagePath: pathName,
                    ),
                  ),
                );
              } catch (e) {
                // If an error occurs, log the error to the console.
                print("There was an error logged : ");
                print(e);
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
        ),
      ),
      ElevatedButton(
          onPressed: () async {
            print("PRESSED!!!!");
            final cameras = await availableCameras();
            final firstCamera = cameras.first;
            TakePictureScreen(camera: cameras.last);
            // Image.file(File(
            //     "/data/user/0/com.example.flutter_application_1/cache/CAP2326513956949563262.jpg"));
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TakePictureScreen(
                        camera: firstCamera,
                      )));
            });
          },
          child: Icon(Icons.rotate_90_degrees_ccw)),
    ]);
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
      body: Image.file(File("/Users/iosdev/Downloads/myImg.jpeg")),
    );
  }
}

List storeImage({String ImagePath = ""}) {
  List imageList = [];
  if (ImagePath == "") {
    return imageList;
  }
  imageList.add(ImagePath);
  print(imageList[0]);
  return imageList;
}
