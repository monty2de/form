import 'package:flutter/material.dart';
import 'dart:math';

import 'package:form/drawer_pages/about.dart';

import 'drawer_pages/curriculum.dart';
import 'drawer_pages/department_activities.dart';
import 'drawer_pages/department_staff.dart';
import 'drawer_pages/exam_committee.dart';
import 'drawer_pages/graduate_studies.dart';
import 'drawer_pages/section_pillars.dart';
import 'drawer_pages/students_affairs.dart';
import 'main.dart';


class NavigationDrawerWidget extends StatefulWidget {

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {

  Random random = new Random();

 late int randomNumber;

 _NavigationDrawerWidgetState() {
 randomNumber =  random.nextInt(512) + 500; 
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
                      Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                        return MyHomePage();    
                        } ));
                    },
                  ),
              
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: ' نبذة عن القسم ',                    
                    onClicked: () {
                      Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                        return About();    
                        } ));
                    },
                  ),

                  const SizedBox(height: 1),
                  buildMenuItem(
                    text: '  اركان القسم ',
                
                    onClicked: () {
                        Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                        return SectionPillars();
                        } ));
                    },
                  ),
                  const SizedBox(height: 1),

                  buildMenuItem(
                    text: '  اللجنة الامتحانية  ',
                
                    onClicked: () {
                        Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                        return ExamCommittee();
                        } ));
                    },
                  ),
                  const SizedBox(height: 1),

                  buildMenuItem(
                    text: '  كادر القسم  ',
                
                    onClicked: () {
                        Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                        return Departmentstaff();
                        } ));
                    },
                  ),
                  const SizedBox(height: 1),

                  buildMenuItem(
                    text: '  شؤون الطلبة  ',
                
                    onClicked: () {
                        Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                        return StudentsAffairs();
                        } ));
                    },
                  ),
                  const SizedBox(height: 1),

                  buildMenuItem(
                    text: '  نشاطات القسم  ',
                
                    onClicked: () {
                        Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                        return Departmentactivities();
                        } ));
                    },
                  ),
                  const SizedBox(height: 1),

                  buildMenuItem(
                    text: '  المناهج  ',
                
                    onClicked: () {
                        Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                        return Curriculum();
                        } ));
                    },
                  ),
                  const SizedBox(height: 1),

                  buildMenuItem(
                    text: '  الدراسات العليا  ',
                
                    onClicked: () {
                        Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                        return GraduateStudies();
                        } ));
                    },
                  ),
                  const SizedBox(height: 1),
                  
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
