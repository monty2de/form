
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/models/examResult.dart';






class ExamResultUpdate extends StatefulWidget {
late int role;

late ExamResult examResult;
  ExamResultUpdate(this.role  , this.examResult );

  @override
  ExamResultUpdateState createState() => ExamResultUpdateState();
}

class ExamResultUpdateState extends State<ExamResultUpdate> {

  var subjectName ;

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  
  var globalKey = GlobalKey<FormState>();
 
  late TextEditingController studentNameController = new TextEditingController(text: this.widget.examResult.studentName);
  late  TextEditingController yearController = new TextEditingController( text: this.widget.examResult.year);
  late  TextEditingController degreeController = new TextEditingController(text: this.widget.examResult.degree );




  Future store(String studentName, year , degree , subjectName) async {


    if(subjectName == null){
      subjectName = this.widget.examResult.subjectName;
    }
    var orders  =  FirebaseFirestore.instance.collection('examResult').doc(this.widget.examResult.id) ;
    await orders.update({
      'id' : this.widget.examResult.id,
      'studentName' : studentName ,
      'year' : year,
      'degree' : degree,
      'subjectName' : subjectName
      
    });
   
   Navigator.pop(context, false);
   
  }



  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.only(left: 120 , right: 120),
      margin: EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
        onPressed:  () {
       
          if(globalKey.currentState!.validate()){
            store(studentNameController.text,  yearController.text , degreeController.text , subjectName );
          }
        },    
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم الطالب',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال العنوان';
              return null;
            },
            controller: studentNameController,
            cursorColor: Colors.black,

            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              icon: Icon(Icons.email, color: Colors.white70),
              

              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          Text(
            '  المرحلة ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال  المرحلة';
              return null;
            },
            controller: yearController,
            cursorColor: Colors.black,

            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              icon: Icon(Icons.email, color: Colors.white70),


              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
         
          Text(
            '  الدرجة ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال  الدرجة';
              return null;
            },
            controller: degreeController,
            cursorColor: Colors.black,

            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              icon: Icon(Icons.email, color: Colors.white70),


              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),

          
         

        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) =>  Scaffold(
    appBar: AppBar(

      leading: IconButton(icon: Icon(Icons.arrow_back_ios ,  ),
        onPressed:() {
          Navigator.pop(context, false);
        },
      ),

    ),


    body:   Form(
      key: globalKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
       
          textSection(),
          buttonSection(),
        ],

      ),
    ),
  );
}
