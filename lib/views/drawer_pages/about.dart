import 'package:flutter/material.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class About extends StatefulWidget {
late int role;
About(this.role);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        title: Text('نبذة عن القسم'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //TODO: ADD THE REQUIRED "ABOUT"
          ],
        ),
      ),
    );
  }
}
