import 'package:flutter/material.dart';
import 'navtej.dart';
import 'package:permission_handler/permission_handler.dart';
import 'nav_sempai_backend.dart';

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
  List teamMembers = ["Navi", "Natsumi"];
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
                child: const Text("Natsumi",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                onPressed: () {
                  navWriteToFile(
                      fName: "myFile.txt", textMsg: "Test message to save");
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
                child: const Text("Tanji",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                onPressed: () {
                  navGetDirectoryPath();
                  navReadFromFile();
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: ClipOval(child: Image.asset("assets/Bara.jpg")),
              trailing: Icon(Icons.bar_chart_rounded),
              title: ElevatedButton(
                child: const Text("Bara",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                onPressed: () async {
                  if (await navRequestStoragePermission() == false) {
                    print("Its denied");
                  }
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: ClipOval(child: Image.asset("assets/Kenjiro.jpg")),
              trailing: Icon(Icons.bar_chart_rounded),
              title: ElevatedButton(
                child: const Text("JiroKen",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
                onPressed: () {
                  navOpenAppSettings();
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              print("CLICKED");
            },
            child: const Text("Next Page"),
          ),
        ],
      ),
    );
  }
}
