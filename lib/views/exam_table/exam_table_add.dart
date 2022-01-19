
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/views/pages_lv3/exam_table_final.dart';
import 'package:form/views/pages_lv3/exam_table_first.dart';





class ExamTableAdd extends StatefulWidget {
late int role;


  ExamTableAdd(this.role );

  @override
  ExamTableAddState createState() => ExamTableAddState();
}

class ExamTableAddState extends State<ExamTableAdd> {

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  
  var globalKey = GlobalKey<FormState>();
 
  late TextEditingController nameController = new TextEditingController();
  late  TextEditingController yearController = new TextEditingController( );
  late  TextEditingController dateController = new TextEditingController(  );




  Future store(String name, year , date) async {

    var id;
    var test_exist = await FirebaseFirestore.instance.collection('examTable').where('year' , isEqualTo: year).get();
    if(test_exist.docs.isEmpty){
       id = generateRandomString(32);

      var check = await FirebaseFirestore.instance.collection('examTable').doc(id).get();
      if(check.exists){
        id = generateRandomString(32);
      }

      var exam_year  =  FirebaseFirestore.instance.collection('examTable').doc(id) ;
      await exam_year.set({
      'id' : id,
      'year' : year,
      
      
      });

    }else{
      test_exist.docs.forEach((data) {           
        id = data.data()['id']   ;
 
      });

    }
    var id_for_item = generateRandomString(32);
    // ignore: unused_local_variable
    var item  =  FirebaseFirestore.instance.collection('examTable').doc(id).collection('Item').doc(id_for_item).set({
      'id' : id_for_item,
      'name' : name,
      'date' : date,
      'year' : year,
      });


    if (year == '4' || year == '3'  || year == '2' || year == '1' || year == '5') {
      Navigator.push(context,
      MaterialPageRoute(builder: (context) {
      return ExamTableFirst(this.widget.role);
     }));
    }
 
    else{
      
      Navigator.push(context,
      MaterialPageRoute(builder: (context) {
      return ExamTableFinal(this.widget.role);
     }));

    }
    
   
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
            store(nameController.text,  yearController.text , dateController.text );
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
         
          Text(
            '  التاريخ ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال  التاريخ';
              return null;
            },
            controller: dateController,
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
