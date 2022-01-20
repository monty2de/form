
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/models/board.dart';




// ignore: must_be_immutable
class BoardUpdate extends StatefulWidget {
late int role;
late Board board;


  BoardUpdate(this.role , this.board);

  @override
  BoardUpdateState createState() => BoardUpdateState();
}

class BoardUpdateState extends State<BoardUpdate> {

  var teacherName ;
  var boardName;

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  
  var globalKey = GlobalKey<FormState>();
 



  Future store(String boardName, teacherName) async {

    // ignore: unnecessary_null_comparison
    if (boardName == null  ) {
      boardName = this.widget.board.name;
    }

    if (teacherName == null  ) {
      teacherName = this.widget.board.teacherName;
    }

    var item  =  FirebaseFirestore.instance.collection('boards').doc(this.widget.board.id) ;
    await item.update({
      'id' : this.widget.board.id,
      'name' : boardName ,
      'teacherName' : teacherName,
      
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
            store(boardName,  teacherName );
          }
        },
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Container textSection() {
    var positionarray = [' اللجنة العلمية' , 'مجلس القسم' , 'لجنة ضمان الجودة' , 'لجنة شؤون الطلبة' , 'اللجنة الامتحانية- اولية' , 'اللجنة الامتحانية-عليا'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم اللجنة  ',
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
              boardName = value.toString();
            },

            ),
        
            

          Text(
            '  اسم العضو ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('teachers').snapshots(),
              builder: (context , snapshot){
                if(!snapshot.hasData){
                  return Text('error');
                }
                List<String> shubjects = [];
                for (var i = 0; i < snapshot.data!.docs.length; i++) {
                  shubjects.add(snapshot.data!.docs[i]['name']);
                }
                return DropdownButtonFormField(

                          items :  shubjects.map( (String item){
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          } ).toList(),

                          onChanged: (value) {
                            teacherName = value.toString();
                          },

            );
              },
            ) ,
         
          

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

      title: Text(' تعديل'),

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
            store(boardName,  teacherName );
          }
        },
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
      ),
        ],

      ),
    ),
  );
}
