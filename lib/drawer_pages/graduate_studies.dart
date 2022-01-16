
import 'package:flutter/material.dart';

import '../drawer.dart';

class GraduateStudies extends StatefulWidget {



  


  @override
  _GraduateStudiesState createState() => _GraduateStudiesState();
}

class _GraduateStudiesState extends State<GraduateStudies> {
 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        
        title: Text('GraduateStudies'),
      ),
      body: Center(
        
        child: Column(
       
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
                child: Text(
                  ' المناهج  ',style: TextStyle(
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
                  ' الطلبة  ',style: TextStyle(
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