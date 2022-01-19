
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/models/teacher.dart';

// ignore: must_be_immutable
class TeacherUpdate extends StatefulWidget {


late int role;
late Teacher teacher;

  TeacherUpdate(this.role , this.teacher );

  @override
  TeacherUpdateState createState() => TeacherUpdateState();
}

class TeacherUpdateState extends State<TeacherUpdate> {
  late  TextEditingController bDateController = new TextEditingController(text: this.widget.teacher.BDate );
  var globalKey = GlobalKey<FormState>();
  late  TextEditingController locationController = new TextEditingController(text: this.widget.teacher.location );
  late  TextEditingController numberController = new TextEditingController(text: this.widget.teacher.number );
var position ;
  late TextEditingController teacherNameController = new TextEditingController(text: this.widget.teacher.name);

 

  // ignore: non_constant_identifier_names
  Future store(String teacherName ,  BDate ,  location , number  , position) async {

    if (position == null) {
      position = this.widget.teacher.position;
    }

      
       FirebaseFirestore.instance.collection('teachers').doc(this.widget.teacher.id,).update({
        'id' : this.widget.teacher.id,
        'name' : teacherName,
        'BDate' : BDate,
        'location' : location,
        'number' : number,
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
                 



            store(teacherNameController.text,  bDateController.text , locationController.text , numberController.text   , position );
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
          buttonSection(),
        ],

      ),
    ),
  );
}
