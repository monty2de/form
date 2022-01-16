import 'package:flutter/material.dart';

import '../drawer.dart';

class Curriculum extends StatefulWidget {
  @override
  _CurriculumState createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('المناهج'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Text(
                ' اولية  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                //         return GraduateStudies();
                //         } ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                ' عليا  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
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
