import 'package:flutter/material.dart';
import 'package:form/views/exam_table/exam_table_add.dart';
import 'package:form/views/exam_table/exam_table_show.dart';

import '../../drawer.dart';


// ignore: must_be_immutable
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

        leading: IconButton(icon: Icon(Icons.arrow_back_ios ,  ),
        onPressed:() {
          Navigator.pop(context, false);
        },
      ),

        actions: [

          

          this.widget.role == 1 || this.widget.role == 2 ? TextButton(
            onPressed: () {
             
             Navigator.push(context,
      MaterialPageRoute(builder: (context) {
      return ExamTableAdd(this.widget.role );
     }));
             
            },
            child: Text(" اضافة  ", style: TextStyle(color: Colors.white)),
          ) :Container(),
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
