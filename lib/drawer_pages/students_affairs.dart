import 'package:flutter/material.dart';

import '../drawer.dart';

class StudentsAffairs extends StatefulWidget {
  @override
  _StudentsAffairsState createState() => _StudentsAffairsState();
}

class _StudentsAffairsState extends State<StudentsAffairs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('شؤن الطلبة'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('الصفحة الشخصية للطالب'),
          ],
        ),
      ),
    );
  }
}
