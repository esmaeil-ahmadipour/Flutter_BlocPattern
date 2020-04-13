import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("Developer: www.ea2.ir"),
      ),
    );

  }
}
