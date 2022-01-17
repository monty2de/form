import 'package:flutter/material.dart';
import 'package:form/views/pages_lv2/curriculum_final.dart';
import 'package:form/views/pages_lv2/curriculum_first.dart';

import '../../drawer.dart';


class Curriculum extends StatefulWidget {
  late int role;

  Curriculum(this.role);

  @override
  _CurriculumState createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
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
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return CurriculumFirst(this.widget.role);
                        } ));
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
                Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                        return CurriculumFinal(this.widget.role);
                        } ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
