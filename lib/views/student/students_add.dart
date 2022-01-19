
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';






class StudentsAdd extends StatefulWidget {


late int role;


  StudentsAdd(this.role  );

  @override
  StudentsAddState createState() => StudentsAddState();
}

class StudentsAddState extends State<StudentsAdd> {
  late  TextEditingController bDateController = new TextEditingController( );
  late  TextEditingController bLocationController = new TextEditingController( );
  late  TextEditingController emailController = new TextEditingController( );
  var globalKey = GlobalKey<FormState>();
  late  TextEditingController locationController = new TextEditingController( );
  late  TextEditingController numberController = new TextEditingController(text: '' );
  late  TextEditingController passController = new TextEditingController( );
var sextype ;
  late TextEditingController studentNameController = new TextEditingController();
  late  TextEditingController yearController = new TextEditingController( );

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  Future store(String studentName , sex , BLocation , BDate ,  location , number , year , email , pass) async {



      UserCredential _authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(), password: pass);
      // add the user to users collection
      
       FirebaseFirestore.instance.collection('students').doc(_authResult.user!.uid,).set({
        'id' : _authResult.user!.uid,
        'name' : studentName,
        'email' : email,
        'sex' : sex,
        'BLocation' : BLocation,
        'BDate' : BDate,
        'location' : location,
        'year' : year,
        'number' : number,
        'pass' : pass,
        'role' :3
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
            store(studentNameController.text,  sextype , bLocationController.text , bDateController.text , locationController.text , numberController.text , yearController.text , emailController.text , passController.text );
          }
        },    
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Container textSection() {
    var sex = ['ذكر' , 'انثى'];
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
              if(value!.isEmpty) return 'يجب ادخال اسم الطالب';
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
          SizedBox(height: 10),
          Column(
            children: [
              Text(
            'الجنس ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          DropdownButtonFormField(

            items :  sex.map( (String item){
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            } ).toList(),

            onChanged: (value) {
              sextype = value.toString();
            },

            ),
            ],
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
            '  مكان الولادة ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال  مكان الولادة';
              return null;
            },
            controller: bLocationController,
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
            '  تاريخ الولادة ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال  تاريخ الولادة';
              return null;
            },
            controller: bDateController,
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
            '  العنوان  ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال  العنوان ';
              return null;
            },
            controller: locationController,
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
            '  رقم الهاتف  ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال  رقم الهاتف ';
              return null;
            },
            controller: numberController,
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
            '   الايميل  ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال   الايميل ';
              return null;
            },
            controller: emailController,
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
            '   كلمة السر  ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال   كلمة السر ';
              return null;
            },
            controller: passController,
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

      title: Text('اضافة طالب'),

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
