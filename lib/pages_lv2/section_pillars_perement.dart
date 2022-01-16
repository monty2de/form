import 'package:flutter/material.dart';

import '../drawer.dart';

class SectionPillarsPerement extends StatefulWidget {
  @override
  _SectionPillarsPerementState createState() => _SectionPillarsPerementState();
}

class _SectionPillarsPerementState extends State<SectionPillarsPerement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Center(child: Text('اركان القسم - الدائمة')),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 400.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Text(
                  ' اللجنة العلمية ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                  //         return GraduateStudies();
                  //         } ));
                },
              ),
              SizedBox(height: 20),
              InkWell(
                child: Text(
                  ' مجلس القسم ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                  //         return GraduateStudies();
                  //         } ));
                },
              ),
              SizedBox(height: 20),
              InkWell(
                child: Text(
                  '  لجنة ضمان الجودة ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                  //         return GraduateStudies();
                  //         } ));
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Text(
                  ' لجنة شؤون الطلبة  ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                  //         return GraduateStudies();
                  //         } ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
