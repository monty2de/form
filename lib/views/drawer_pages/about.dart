import 'package:flutter/material.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class About extends StatefulWidget {


  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
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
