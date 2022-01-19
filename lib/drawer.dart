import 'package:flutter/material.dart';
import 'package:form/views/drawer_pages/about.dart';
import 'package:form/views/drawer_pages/curriculum.dart';
import 'package:form/views/drawer_pages/department_activities.dart';
import 'package:form/views/drawer_pages/department_staff.dart';
import 'package:form/views/drawer_pages/exam_committee.dart';
import 'package:form/views/drawer_pages/graduate_studies.dart';
import 'package:form/views/drawer_pages/section_pillars.dart';
import 'package:form/views/drawer_pages/students_affairs.dart';
import 'package:form/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'main.dart';

// ignore: must_be_immutable
class NavigationDrawerWidget extends StatefulWidget {
  late int role;

  NavigationDrawerWidget(this.role);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  Random random = new Random();

  late int randomNumber;

  _NavigationDrawerWidgetState() {
    randomNumber = random.nextInt(512) + 500;
  }
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue[900],
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  buildMenuItem(
                    text: ' الصفحة الرئيسية   ',
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(role: this.widget.role,);
                      }));
                    },
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: ' نبذة عن القسم ',
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return About(this.widget.role);
                      }));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  اركان القسم ',
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SectionPillars(this.widget.role);
                      }));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  اللجنة الامتحانية  ',
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ExamCommittee(this.widget.role);
                      }));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  كادر القسم  ',
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Departmentstaff(this.widget.role);
                      }));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  شؤون الطلبة  ',
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return StudentsAffairs(this.widget.role);
                      }));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  نشاطات القسم  ',
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Departmentactivities(this.widget.role);
                      }));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  المناهج  ',
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Curriculum(this.widget.role);
                      }));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  الدراسات العليا  ',
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return GraduateStudies(this.widget.role);
                      }));
                    },
                  ),
                  const SizedBox(height: 1),

                  buildMenuItem(
                    text: '   تسجيل الخروج  ',
                    onClicked: () async {
                     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                      sharedPreferences.clear();
                      // ignore: deprecated_member_use
                      sharedPreferences.commit();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Login();
                      }));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    // required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
