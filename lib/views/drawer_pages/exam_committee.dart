import 'package:flutter/material.dart';
import 'package:form/views/pages_lv2/examCommittee_final.dart';
import 'package:form/views/pages_lv2/examCommittee_first.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class ExamCommittee extends StatefulWidget {
  late int role;

  ExamCommittee(this.role);

  @override
  _ExamCommitteeState createState() => _ExamCommitteeState();
}

class _ExamCommitteeState extends State<ExamCommittee> {
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
                '  اولية ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamCommitteeFirst(this.widget.role);
                        } ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  عليا ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamCommitteeFinal(this.widget.role);
                        } ));
              },
            ),
            
            
            
           
            
          ],
        ),
      ),
    );
  }
}
