import 'package:flutter/material.dart';

import '../../drawer.dart';


class Departmentactivities extends StatefulWidget {
  late int role;

  Departmentactivities(this.role);

  @override
  _DepartmentactivitiesState createState() => _DepartmentactivitiesState();
}

class _DepartmentactivitiesState extends State<Departmentactivities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        title: Text('نشاطات القسم'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(''),
          ],
        ),
      ),
    );
  }
}
