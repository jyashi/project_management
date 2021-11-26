import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/nav_sempai_backend.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'home_page.dart';

/*
TO DO:
- Size box to contain image with
- Saving the image appropriately so it is loaded on restart
- Arrays or Maps to use class in different instances
*/

class NavImageBox extends StatefulWidget {
  const NavImageBox({Key? key}) : super(key: key);

  @override
  _NavImageBoxState createState() => _NavImageBoxState();
}

XFile? img;
XFile? imageFile;

Future<String> getGalleryImage() async {
  img = await ImagePicker().pickImage(source: ImageSource.gallery);
  var imgPath = img!.path;
  if (img == null) return "";
  return imgPath;
}

class _NavImageBoxState extends State<NavImageBox> {
  navTakePicture() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    String dir = directory.path;
    XFile? img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
    );
    String imagePath = img
            ?.path ?? // This ?? operator is important as a backup in case value was null
        "/data/user/0/com.example.flutter_application_1/app_flutter/image1.jpg";
    final File imageStored = await File(imagePath).copy(dir + "/image1.jpg");

    // bodyText = dir + "/image1.jpg";

    // bodyText = imageStored.path;
    setState(() {
      imageStored;
      // imageStored;
      imageFile = img;
      // print("|||||");
      // print(imageFile?.path.toString());
    });
  }

  Widget navShowPic() {
    if (imageFile != null) {
      String _path = imageFile!.path;
      print("IF fired");
      // bodyText = _path;

      return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image.file(
          File(_path),
          width: 350,
          height: 350,
          fit: BoxFit.contain,
        ),
      );
    } else {
      print("Else fired");
      return Container(
        alignment: Alignment.center,
        child: Icon(Icons.error_sharp),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      navShowPic(),

      SizedBox(
        width: 300,
        height: 400,
        child: TextButton(
          onPressed: () {
            // getGalleryImage();
            navTakePicture();
          },
          child: Container(),
        ),
      ),

      // Card(
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(75.0),
      //     child: Image.asset(
      //       "assets/me.JPEG",
      //       width: 350,
      //       height: 350,
      //       fit: BoxFit.contain,
      //     ),
      //   ),
      // ),
    ]);
  }
}
