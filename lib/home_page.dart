// import 'dart:html';

import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/diary_template.dart';
import 'package:flutter_application_1/nav_camera_page.dart';
import 'package:path_provider/path_provider.dart';
import 'navtej.dart';
import 'package:permission_handler/permission_handler.dart';
import 'nav_sempai_backend.dart';
// import 'package:path/path.dart' as p;
import 'package:camera/camera.dart';
// import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// import 'package:xfile/xfile.dart' as xf;

class MyScaffold extends StatelessWidget {
  const MyScaffold({Key? key}) : super(key: key);
  final String textHeader = "Home page";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Material app title",
        theme:
            ThemeData(brightness: Brightness.light, primaryColor: Colors.blue),
        home: Scaffold(
          appBar: AppBar(
              title: Text(textHeader),
              actions: <Widget>[
                IconButton(
                    onPressed: () => MyDrawer(), icon: Icon(Icons.handyman))
              ],
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu))),
          body: MyBodyText(),
        ));
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.blueGrey,
    ));
  }
}

class MyBodyText extends StatefulWidget {
  const MyBodyText({Key? key}) : super(key: key);

  @override
  _MyBodyTextState createState() => _MyBodyTextState();
}

class _MyBodyTextState extends State<MyBodyText> {
  String bodyText = "Watch this text";

  XFile? imageFile;
  File? imageStored;
  // late File imageFile;
  navTakePicture() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    String dir = directory.path;
    XFile? img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
    );
    String imagePath = img!.path;
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
      bodyText = _path;

      return Image.file(File(_path));
    } else {
      print("Else fired");
      return Container(
        child: Icon(Icons.error_sharp),
      );
    }
  }

  Future<Widget> navShowPicture() async {
    if (imageStored != null) {
      String _path = imageStored!.path;
      print(_path);
      bodyText = _path;

      return Image.file(File(_path));
    } else {
      return Container(
        child: Icon(Icons.error_sharp),
      );
      // String path = imageFile!.path;

    }
  }

  void changeBodyText() {
    setState(() {
      bodyText = "You clicked it!!!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            height: 50,
            child: const Text("Project Overview",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold)),
          ),
          Card(
            child: ListTile(
              leading: ClipOval(child: Image.asset("assets/Natsumi.jpg")),
              trailing: Icon(Icons.bar_chart),
              title: ElevatedButton(
                child: const Text("Write Text to file",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                onPressed: () {
                  navRequestCameraPermission();
                  navRequestStoragePermission();

                  navWriteToFile(
                      fName: "natsumiFile.txt",
                      textMsg: "You have logged in x times");
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: ClipOval(child: Image.asset("assets/me.JPEG")),
              trailing: Icon(Icons.bar_chart_rounded),
              title: ElevatedButton(
                child: const Text("Navtej",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Navtej()));
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: ClipOval(child: Image.asset("assets/Tanji.jpg")),
              trailing: Icon(Icons.bar_chart_rounded),
              title: ElevatedButton(
                child: const Text("Read text from file",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                onPressed: () {
                  navReadFromFile(fName: "natsumiFile.txt");
                  navReadFromFile(fName: "baraFile.txt");
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: ClipOval(child: Image.asset("assets/Bara.jpg")),
              trailing: Icon(Icons.bar_chart_rounded),
              title: ElevatedButton(
                child: const Text("Write numbers to second file",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  List<String> myStringList = ["First list", "second list"];
                  List<double> myDoubleList = [45.0, 22.0];
                  navWriteToFile(
                      fName: "baraFile.txt", textMsg: myDoubleList.toString());
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: ClipOval(child: Image.asset("assets/Kenjiro.jpg")),
              trailing: Icon(Icons.bar_chart_rounded),
              title: ElevatedButton(
                child: const Text("Delete file",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                onPressed: () {
                  // navOpenAppSettings();
                  // navReadFromFile(fName: "yourFile.txt");
                  // navDeleteFile(fName: "natsumiFile.txt", ARE_YOU_SURE: true);
                  // navDeleteFile(fName: "baraFile.txt", ARE_YOU_SURE: true);
                  testFn();
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                bodyText = "New text";
              });

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DiaryHomeScreen()));
            },
            child: const Text("Next Page"),
          ),
          IconButton(
              onPressed: () async {
                print("Trigger 1 fired");
                // navTakePicture();
                // navReadFromFile(fName: "mapData.json");
                // navShowDialogue(context);
              },
              icon: Icon(Icons.camera_alt_sharp)),
          Text("$bodyText"),
          navShowPic(),
        ],
      ),
    );
  }
}

testFn() {
  HashMap<String, String> myMap = HashMap();
  myMap["path"] = "../assets/";
  myMap["textMsg"] = "This is my memo message";

  navWriteToFile(fName: "mapData.json", textMsg: jsonEncode(myMap));
  print("Values encoded");
}
