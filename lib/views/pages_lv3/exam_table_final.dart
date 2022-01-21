import 'package:flutter/material.dart';
import 'package:form/views/exam_table/exam_table_add.dart';
import 'package:form/views/exam_table/exam_table_show.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class ExamTableFinal extends StatefulWidget {
  late int role;

  ExamTableFinal(this.role);

  @override
  _ExamTableFinalState createState() => _ExamTableFinalState();
}

class _ExamTableFinalState extends State<ExamTableFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        actions: [
          this.widget.role == 1 || this.widget.role == 2
              ? TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ExamTableAdd(this.widget.role);
                    }));
                  },
                  child:
                      Text(" اضافة  ", style: TextStyle(color: Colors.white)),
                )
              : Container(),
        ],
        centerTitle: true,
        title: Text('جدول الامتحانات'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Text(
                '  المرحلة الاولى  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExamTableShow(this.widget.role, 'عليا اولى');
                }));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  المرحلة الثانية  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExamTableShow(this.widget.role, 'عليا ثانية');
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
