import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Text("There here")],
      ),
      alignment: Alignment.center,
    );
  }
}
