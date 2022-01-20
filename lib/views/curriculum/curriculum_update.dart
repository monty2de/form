
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/models/curriculum.dart';




// ignore: must_be_immutable
class CurriculumUpdate extends StatefulWidget {
late int role;
late Curriculum curriculum;

  CurriculumUpdate(this.role  , this.curriculum) ;

  @override
  CurriculumUpdateState createState() => CurriculumUpdateState();
}

class CurriculumUpdateState extends State<CurriculumUpdate> {

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  
  var globalKey = GlobalKey<FormState>();
 
  late TextEditingController nameController = new TextEditingController( text: this.widget.curriculum.name);
  late  TextEditingController yearController = new TextEditingController( text: this.widget.curriculum.year );



  Future store(String name, year) async {


   
    var subject  =  FirebaseFirestore.instance.collection('curriculum').doc(this.widget.curriculum.id) ;
    await subject.update({
      'id' : this.widget.curriculum.id,
      'name' : name ,
      'year' : year,

      
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
            store(nameController.text,  yearController.text );
          }
        },
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'العنوان',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال العنوان';
              return null;
            },
            controller: nameController,
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
            '  الوصف ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال  الوصف';
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

      title: Text('تعديل '),

    ),


    body:   Form(
      key: globalKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
       
          textSection(),
          // buttonSection(),

          ElevatedButton(
        onPressed:  () {
       
          if(globalKey.currentState!.validate()){
            store(nameController.text,  yearController.text );
          }
        },
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
      ),
        ],

      ),
    ),
  );
}
