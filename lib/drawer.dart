import 'package:flutter/material.dart';
import 'package:form/views/drawer_pages/about.dart';
import 'package:form/views/drawer_pages/department_activities.dart';
import 'package:form/views/drawer_pages/department_staff.dart';
import 'package:form/views/drawer_pages/students_affairs.dart';
import 'package:form/views/login.dart';
import 'package:form/views/pages_lv2/curriculum_final.dart';
import 'package:form/views/pages_lv2/curriculum_first.dart';
import 'package:form/views/pages_lv2/examCommittee_final.dart';
import 'package:form/views/pages_lv2/examCommittee_first.dart';
import 'package:form/views/pages_lv2/section_pillars_perement.dart';
import 'package:form/views/student/students_name_final_show.dart';
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
                    text: '  اركان القسم-الدائمة ',
                    onClicked: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SectionPillarsPerement(this.widget.role);
                  }));
                    },
                  ),

                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  اركان القسم-المؤقتة ',
                    onClicked: () {
                      
                    },
                  ),

                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  اللجنة الامتحانية-اولية  ',
                    onClicked: () {
                      Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamCommitteeFirst(this.widget.role);
                        } ));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  اللجنة الامتحانية-عليا  ',
                    onClicked: () {
                      Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamCommitteeFinal(this.widget.role);
                        } ));
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
                    text: '  المناهج-اولية  ',
                    onClicked: () {
                      Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return CurriculumFirst(this.widget.role);
                        } ));
                    },
                  ),

                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  المناهج-عليا  ',
                    onClicked: () {
                      Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return CurriculumFinal(this.widget.role);
                        } ));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: ' الدراسات العليا-المناهج  ',
                    onClicked: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                      return CurriculumFinal(this.widget.role);
                      }));
                    },
                  ),
                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: ' الدراسات العليا-الطلبة  ',
                    onClicked: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                      return StudentsNamesFinalShow(this.widget.role);
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
