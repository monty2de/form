import 'package:flutter/material.dart';
import 'package:form/views/pages_lv3/exam_result_first.dart';
import 'package:form/views/pages_lv3/exam_table_first.dart';
import 'package:form/views/pages_lv3/students_names_first.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class ExamCommitteeFirst extends StatefulWidget {
  late int role;

  ExamCommitteeFirst(this.role);

  @override
  _ExamCommitteeFirstState createState() => _ExamCommitteeFirstState();
}

class _ExamCommitteeFirstState extends State<ExamCommitteeFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(

        leading: IconButton(icon: Icon(Icons.arrow_back_ios ,  ),
        onPressed:() {
          Navigator.pop(context, false);
        },
      ),
        title: Text(' اللجنة الامتحانية الاولية' ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            
            InkWell(
              child: Text(
                '  اعضاء اللجنة ',
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
                '  اسماء الطلبة ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return StudentsNamesFirst(this.widget.role);
                        } ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  جدول الامتحانات  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamTableFirst(this.widget.role);
                        } ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  نتائج الطلبة  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamResultFirst(this.widget.role);
                        } ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
