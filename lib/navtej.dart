import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';

class Navtej extends StatelessWidget {
  const Navtej({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Navtej page",
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyScaffold()));
              },
              icon: const Icon(Icons.arrow_back)),
          title: ListTile(
            leading: ClipOval(child: Image.asset("assets/me.JPEG")),
            title: Text("Navtej",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
          ),
        ),
        body: NavtejBody(),
      ),
    );
  }
}

class NavtejBody extends StatefulWidget {
  const NavtejBody({Key? key}) : super(key: key);

  @override
  _NavtejBodyState createState() => _NavtejBodyState();
}

class _NavtejBodyState extends State<NavtejBody> {
  String textProject = "Project Overview:";

  @override
  Widget build(BuildContext context) {
    return Center(
      // widthFactor: double.infinity,
      child: Column(
        children: [
          Card(
            child: Container(
              width: double.infinity,
              child: ListTile(
                title: Column(children: [
                  Padding(padding: EdgeInsets.all(8)),
                  Text("$textProject",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25)),
                  Padding(padding: EdgeInsets.all(8)),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        text: "Hello\n",
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "The main body goes here.",
                          ),
                          TextSpan(text: "So this will open in a new line?")
                        ]),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
