
import 'package:flutter/material.dart';

import '../drawer.dart';

class ExamCommittee extends StatefulWidget {



  


  @override
  _ExamCommitteeState createState() => _ExamCommitteeState();
}

class _ExamCommitteeState extends State<ExamCommittee> {
 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        
        title: Text('ExamCommittee'),
      ),
      body: Center(
        
        child: Column(
       
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
                child: Text(
                  '  اولية ',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),
                ),

                onTap: (){

                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                  //         return GraduateStudies();
                  //         } ));
                },
              ),
             SizedBox(height: 20,),
             InkWell(
                child: Text(
                  '  عليا ',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),
                ),

                onTap: (){

                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                  //         return GraduateStudies();
                  //         } ));
                },
              ),

          Divider(),



          InkWell(
                child: Text(
                  '  اعضاء اللجنة ',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),
                ),

                onTap: (){

                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                  //         return GraduateStudies();
                  //         } ));
                },
              ),
             SizedBox(height: 20,),
             InkWell(
                child: Text(
                  '  اسماء الطلبة ',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),
                ),

                onTap: (){

                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                  //         return GraduateStudies();
                  //         } ));
                },
              ),

              SizedBox(height: 20,),
              InkWell(
                child: Text(
                  '  جدول الامتحانات  ',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),
                ),

                onTap: (){

                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                  //         return GraduateStudies();
                  //         } ));
                },
              ),
             SizedBox(height: 20,),
             InkWell(
                child: Text(
                  '  نتائج الطلبة  ',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.black
          ),
                ),

                onTap: (){

                  // Navigator.push(context, MaterialPageRoute( builder:  ( context ){ 
                  //         return GraduateStudies();
                  //         } ));
                },
              ),

          ],
        ),
      ),
    );
  }
}