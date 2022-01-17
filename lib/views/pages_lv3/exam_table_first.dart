import 'package:flutter/material.dart';
import 'package:form/Controllers/curriculumController.dart';
import 'package:form/models/curriculum.dart';
import 'package:form/views/pages_lv4/exam_table_show.dart';

import '../../drawer.dart';
import '../exam_table_add.dart';


class ExamTableFirst extends StatefulWidget {

  late int role;

  ExamTableFirst(this.role);

  @override
  _ExamTableFirstState createState() => _ExamTableFirstState();
}

class _ExamTableFirstState extends State<ExamTableFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(

        actions: [

          this.widget.role == 1 ? FlatButton(
            onPressed: () {
             
             
             
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ExamTableAdd(this.widget.role )), (Route<dynamic> route) => false);
            },
            child: Text(" اضافة  ", style: TextStyle(color: Colors.white)),
          ) :Container(),
        ],
        centerTitle: true,
        title: Text('المناهج'),
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
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamTableShow(this.widget.role , 1);
                        } ));
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
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamTableShow(this.widget.role , 2);
                        } ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  المرحلة الثالثة   ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamTableShow(this.widget.role , 3);
                        } ));
              },
            ),

            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  المرحلة الرابعة   ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamTableShow(this.widget.role , 4);
                        } ));
              },
            ),

            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  المرحلة الخامسة   ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return ExamTableShow(this.widget.role , 5);
                        } ));
              },
            ),
            
          ],
        ),
      ),
    );
  }


   
}
