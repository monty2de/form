import 'package:flutter/material.dart';
import 'package:form/views/pages_lv2/curriculum_final.dart';

import '../../drawer.dart';

class GraduateStudies extends StatefulWidget {

  late int role;

  GraduateStudies(this.role);

  @override
  _GraduateStudiesState createState() => _GraduateStudiesState();
}

class _GraduateStudiesState extends State<GraduateStudies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        title: Text('الدراسات العليا'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Text(
                ' المناهج  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return CurriculumFinal(this.widget.role);
                }));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                ' الطلبة  ',
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
    );
  }
}
