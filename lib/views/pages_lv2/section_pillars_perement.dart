import 'package:flutter/material.dart';
import 'package:form/views/board/board_add.dart';
import 'package:form/views/board/board_show.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class SectionPillarsPerement extends StatefulWidget {
  late int role;

  SectionPillarsPerement(this.role);

  @override
  _SectionPillarsPerementState createState() => _SectionPillarsPerementState();
}

class _SectionPillarsPerementState extends State<SectionPillarsPerement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(

        actions: [

          this.widget.role == 1 || this.widget.role == 2 ? TextButton(
            onPressed: () {
             
             Navigator.push(context,
             MaterialPageRoute(builder: (context) {
             return BoardAdd(this.widget.role  );
             }));
             
            },
            child: Text(" اضافة عضو ", style: TextStyle(color: Colors.white)),
          ) :Container(),
        ],

        
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
                  Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                          return BoardShow(this.widget.role, ' اللجنة العلمية');
                          } ));
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
                  Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                          return BoardShow(this.widget.role, 'مجلس القسم');
                          } ));
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
                  Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                          return BoardShow(this.widget.role, 'لجنة ضمان الجودة');
                          } ));
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
                  Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                          return BoardShow(this.widget.role, 'لجنة شؤون الطلبة');
                          } ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
