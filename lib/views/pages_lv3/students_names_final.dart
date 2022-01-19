import 'package:flutter/material.dart';
import 'package:form/views/pages_lv4/students_name_show.dart';
import 'package:form/views/student/students_add.dart';

import '../../drawer.dart';


// ignore: must_be_immutable
class StudentsNamesFinal extends StatefulWidget {

  late int role;

  StudentsNamesFinal(this.role);

  @override
  _StudentsNamesFinalState createState() => _StudentsNamesFinalState();
}

class _StudentsNamesFinalState extends State<StudentsNamesFinal> {
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

          

          this.widget.role == 1 ? TextButton(
            onPressed: () {
             
              Navigator.push(context,
              MaterialPageRoute(builder: (context) {
              return StudentsAdd(this.widget.role   );
              }));
                  
            },
            child: Text(" اضافة  ", style: TextStyle(color: Colors.white)),
          ) :Container(),
        ],
        centerTitle: true,
        title: Text('اسماء الطلبة'),
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
                        return StudentsNamesShow(this.widget.role , 6);
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
                        return StudentsNamesShow(this.widget.role , 7);
                        } ));
              },
            ),
            
            
          ],
        ),
      ),
    );
  }


   
}
