import 'package:flutter/material.dart';
import 'package:form/views/pages_lv3/exam_result_final.dart';
import 'package:form/views/pages_lv3/exam_table_final.dart';

import '../../drawer.dart';

class ExamCommitteeFinal extends StatefulWidget {
  late int role;

  ExamCommitteeFinal(this.role);

  @override
  _ExamCommitteeFinalState createState() => _ExamCommitteeFinalState();
}

class _ExamCommitteeFinalState extends State<ExamCommitteeFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        title: Text('اللجنة الامتحانية'),
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
                '  جدول الامتحانات  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamTableFinal(this.widget.role);
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
                        return ExamResultFinal(this.widget.role);
                        } ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
