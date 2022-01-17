
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/views/pages_lv2/curriculum_final.dart';
import 'package:form/views/pages_lv2/curriculum_first.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';



class CurriculumAdd extends StatefulWidget {
late int role;
late int type;

  CurriculumAdd(this.role , this.type);

  @override
  CurriculumAddState createState() => CurriculumAddState();
}

class CurriculumAddState extends State<CurriculumAdd> {

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  
  var globalKey = GlobalKey<FormState>();
 
  late TextEditingController nameController = new TextEditingController();
  late  TextEditingController yearController = new TextEditingController(  );



  Future store(String name, year) async {


    var id = generateRandomString(32);

    var check = await FirebaseFirestore.instance.collection('curriculum').doc(id).get();
    if(check.exists){
      id = generateRandomString(32);
    }

    var orders  =  FirebaseFirestore.instance.collection('curriculum').doc(id) ;
    await orders.set({
      'id' : id,
      'name' : name ,
      'year' : year,
      'type' :this.widget.type
      
    });
    if (this.widget.type == 1) {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) {
      return CurriculumFirst(this.widget.role);
     }));
    }else{
      
      Navigator.push(context,
      MaterialPageRoute(builder: (context) {
      return CurriculumFinal(this.widget.role);
     }));

    }
    
   
  }



  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.only(left: 120 , right: 120),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed:  () {
       
          if(globalKey.currentState!.validate()){
            store(nameController.text,  yearController.text );
          }
        },
        elevation: 0.0,
        color: Colors.red[600],
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
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
