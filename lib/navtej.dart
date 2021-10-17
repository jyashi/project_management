import 'package:flutter/material.dart';
import 'dart:io';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'home_page.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:path_provider/path_provider.dart';
import 'data_storage.dart';
import 'package:permission_handler/permission_handler.dart';

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
          SensorDataBody(),
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
  //-------------Initialize variables---------------------------
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  String textSaveMessage = "";
  String textPathName = "";

//-------------------------------------------------------------------------
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(8)),
          Text("Data gathered from phone Accelerometer",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
              )),
          Padding(padding: EdgeInsets.all(8)),
          ElevatedButton(
              onPressed: () {
                accelerometerEvents.listen((AccelerometerEvent event) {
                  setState(() {
                    x = event.x;
                    y = event.y;
                    z = event.z;
                    CounterStorage();
                    @override
                    Widget build(BuildContext context) {
                      return Center(child: Text("$x"));
                    }
                  });
                });
              },
              child: Text("Generate data")),
          Padding(padding: EdgeInsets.all(8)),

          Container(
            width: 300,
            child: Card(
              child: SfSparkBarChart(
                data: [x, y, z],
                negativePointColor: Colors.red,
                axisCrossesAt: 0,
                labelDisplayMode: SparkChartLabelDisplayMode.all,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text("X Value"), Text("Y Value"), Text("Z Value")],
          ),
          Padding(padding: EdgeInsets.all(8)),
          ElevatedButton(
              onPressed: () {
                bool loading = false;
                // Future<bool> saveFile(String fileName) async {
                //   Directory directory;
                //   try{

                //   }catch(e){

                //   }
                // }
                Future<bool> _requestPermission(Permission permission) async {
                  textSaveMessage = "YES ITS WORKING!!!!";
                  print("YES ITS WORKING");
                  if (await permission.isGranted) {
                    return true;
                  } else {
                    var result = await permission.request();
                    if (result == PermissionStatus.granted) {
                      return true;
                    } else {
                      return false;
                    }
                  }
                }

                CounterStorage().writeCounter("Hello world");
                String path = "/storage/emulated/0/Android/data/";
                File(path + "file.txt").writeAsString("Hello world");
                textSaveMessage = "Your Data has been saved inside :" + path;

                Future.delayed(const Duration(seconds: 4), () {
                  textSaveMessage = "";
                });
              },
              child: Text("Save data to file ")),
          Text(
            "$textSaveMessage",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          //Child
        ],
      ),
    );
  }
}

Future<String> get _localPath async {
  Directory dir = await getApplicationDocumentsDirectory();
  return dir.path;
}
