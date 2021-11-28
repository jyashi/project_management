import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/nav_image_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DiaryHomeScreen extends StatelessWidget {
  const DiaryHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyScaffold()));
              },
              icon: Icon(Icons.backspace))),
      body: ListView(
        children: [
          Center(child: NavImageBox()),
        ],
      ),
    );
  }
}
