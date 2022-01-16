
import 'package:flutter/material.dart';

import '../drawer.dart';

class StudentsAffairs extends StatefulWidget {



  


  @override
  _StudentsAffairsState createState() => _StudentsAffairsState();
}

class _StudentsAffairsState extends State<StudentsAffairs> {
 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        
        title: Text('StudentsAffairs'),
      ),
      body: Center(
        
        child: Column(
       
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
           
          ],
        ),
      ),
    );
  }
}