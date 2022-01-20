
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TeacherAdd extends StatefulWidget {


late int role;


  TeacherAdd(this.role  );

  @override
  TeacherAddState createState() => TeacherAddState();
}

class TeacherAddState extends State<TeacherAdd> {
  late  TextEditingController bDateController = new TextEditingController( );
  late  TextEditingController emailController = new TextEditingController( );
  var globalKey = GlobalKey<FormState>();
  late  TextEditingController locationController = new TextEditingController( );
  late  TextEditingController numberController = new TextEditingController(text: '' );
  late  TextEditingController passController = new TextEditingController( );
var position ;
  late TextEditingController teacherNameController = new TextEditingController();

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  // ignore: non_constant_identifier_names
  Future store(String teacherName ,  BDate ,  location , number  , email , pass , position) async {



      UserCredential _authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(), password: pass);
      // add the user to users collection
      
       FirebaseFirestore.instance.collection('teachers').doc(_authResult.user!.uid,).set({
        'id' : _authResult.user!.uid,
        'name' : teacherName,
        'email' : email,
        'BDate' : BDate,
        'location' : location,
        'number' : number,
        'pass' : pass,
        'role' :2,
        'position' : position
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
                 



            store(teacherNameController.text,  bDateController.text , locationController.text , numberController.text  , emailController.text , passController.text , position );
          }
        },    
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Container textSection() {
    var positionarray = ['منتسب' , 'خدمات' , 'تدريسي' , 'مهندس'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'الاسم ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value){
              if(value!.isEmpty) return 'يجب ادخال اسم ';
              return null;
            },
            controller: teacherNameController,
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
            'العنوان الوظيفي ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          DropdownButtonFormField(

            items :  positionarray.map( (String item){
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            } ).toList(),

            onChanged: (value) {
              position = value.toString();
            },

            ),
            ],
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

      title: Text('اضافة موظف'),

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
                 



            store(teacherNameController.text,  bDateController.text , locationController.text , numberController.text  , emailController.text , passController.text , position );
          }
        },    
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
      ),
        ],

      ),
    ),
  );
}
