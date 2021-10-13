import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sensors_plus/sensors_plus.dart';

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
        body: Column(
          children: [
            ProjectOverview(),
          ],
        ),
      ),
    );
  }
}

class ProjectOverview extends StatefulWidget {
  const ProjectOverview({Key? key}) : super(key: key);

  @override
  _ProjectOverviewState createState() => _ProjectOverviewState();
}

class _ProjectOverviewState extends State<ProjectOverview> {
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
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                        text:
                            "1. Looked at sensors_plus library to access sensor data\n\n",
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "2. Extracted sensor data to JSON file.\n\n",
                          ),
                          TextSpan(
                              text:
                                  "3. Played around with different layouts of flutter.\n\n")
                        ]),
                  ),
                ]),
              ),
            ),
          ),
          Icon(Icons.access_alarm),
          Icon(Icons.add_chart),
          //Next child
        ],
      ),
    );
  }
}

class SensorDataBody extends StatefulWidget {
  const SensorDataBody({Key? key}) : super(key: key);

  @override
  _SensorDataBodyState createState() => _SensorDataBodyState();
}

class _SensorDataBodyState extends State<SensorDataBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
