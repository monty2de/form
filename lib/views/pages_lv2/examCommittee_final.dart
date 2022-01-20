import 'package:flutter/material.dart';
import 'package:form/views/board/board_show.dart';
import 'package:form/views/pages_lv3/exam_result_final.dart';
import 'package:form/views/pages_lv3/exam_table_final.dart';
import 'package:form/views/pages_lv3/students_names_final.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
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

        leading: IconButton(icon: Icon(Icons.arrow_back_ios ,  ),
        onPressed:() {
          Navigator.pop(context, false);
        },
      ),
        title: Text('اللجنة الامتحانية-عليا'),
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
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                          return BoardShow(this.widget.role, 'اللجنة الامتحانية-عليا');
                          } ));
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
                        return StudentsNamesFinal(this.widget.role);
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
