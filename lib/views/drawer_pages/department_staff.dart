import 'package:flutter/material.dart';
import 'package:form/views/teacher/teacher_add.dart';
import 'package:form/views/teacher/teacher_show.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class Departmentstaff extends StatefulWidget {
  late int role;

  Departmentstaff(this.role);

  @override
  _DepartmentstaffState createState() => _DepartmentstaffState();
}

class _DepartmentstaffState extends State<Departmentstaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        actions: [

          this.widget.role == 1 ? TextButton(
          onPressed: () {
              
            Navigator.push(context,
            MaterialPageRoute(builder: (context) {
            return TeacherAdd(this.widget.role  );
            }));

          },
          child: Text(" اضافة  ", style: TextStyle(color: Colors.white)),
          ) :Container(),
        ],
        centerTitle: true,
        title: Text('كادر القسم'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Text(
                ' التدريسين  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return TeacherShow(this.widget.role, 'تدريسي');
                        } ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                ' مهندسين  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return TeacherShow(this.widget.role, 'مهندس');
                        } ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                ' منتسبين  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return TeacherShow(this.widget.role, 'منتسب');
                        } ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                ' خدمات  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return TeacherShow(this.widget.role, 'خدمات');
                        } ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
