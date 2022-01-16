import 'package:flutter/material.dart';
import 'package:form/pages_lv2/section_pillars_perement.dart';

import '../drawer.dart';

class SectionPillars extends StatefulWidget {
  @override
  _SectionPillarsState createState() => _SectionPillarsState();
}

class _SectionPillarsState extends State<SectionPillars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('اركان القسم'),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 400.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Text(
                  ' الدائمة ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SectionPillarsPerement();
                  }));
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                child: Text(
                  ' المؤقتة ',
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
      ),
    );
  }
}
