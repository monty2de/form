import 'package:flutter/material.dart';
import 'package:form/views/student/student_add_update.dart';
import 'package:form/views/student/student_search.dart';
import 'package:form/views/student/students_name_show.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class StudentsNamesFinal extends StatefulWidget {
  late int role;

  StudentsNamesFinal(this.role);

  @override
  _StudentsNamesFinalState createState() => _StudentsNamesFinalState();
}

class _StudentsNamesFinalState extends State<StudentsNamesFinal> {
  late TextEditingController studentNameController = new TextEditingController();

  var globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        actions: [
          this.widget.role == 1 || this.widget.role == 2
              ? TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StudentAddUpdate(this.widget.role);
                    }));
                  },
                  child:
                      Text(" اضافة  ", style: TextStyle(color: Colors.white)),
                )
              : Container(),
        ],
        centerTitle: true,
        title: Text('اسماء الطلبة'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Form(
              key: globalKey,
              child: Column(
                children: [
                  textSection(),
                  ElevatedButton(
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchStudent(
                              this.widget.role, studentNameController.text);
                        }));
                      }
                    },
                    child:
                        Text(" بحث", style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
            Center(
              child: InkWell(
                child: Text(
                  '  المرحلة الاولى  ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StudentsNamesShow(this.widget.role, 'عليا اولى');
                  }));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                child: Text(
                  '  المرحلة الثانية  ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StudentsNamesShow(this.widget.role, 'عليا ثانية');
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم الطالب',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال اسم الطالب';
              return null;
            },
            controller: studentNameController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              // icon: Icon(Icons.email, color: Colors.white70),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
