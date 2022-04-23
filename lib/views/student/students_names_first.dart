import 'package:flutter/material.dart';
import 'package:form/views/student/student_search.dart';
import 'package:form/views/student/students_name_show.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class StudentsNamesFirst extends StatefulWidget {
  late int role;

  StudentsNamesFirst(this.role);

  @override
  _StudentsNamesFirstState createState() => _StudentsNamesFirstState();
}

class _StudentsNamesFirstState extends State<StudentsNamesFirst> {
  late TextEditingController studentNameController =
      new TextEditingController();

  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        centerTitle: true,
        title: Text('اسماء الطلبة'),
      ),
      body: Center(
        child: Column(
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
                    child: Text("بحث", style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
            yearWidget(
                year: 'الأولى',
                title: 'المرحلة الأولى',
                context: context,
                role: widget.role),
            SizedBox(height: 20),
            yearWidget(
                year: 'الثانية',
                title: 'المرحلة الثانية',
                context: context,
                role: widget.role),
            SizedBox(height: 20),
            yearWidget(
                year: 'الثالثة',
                title: 'المرحلة الثالثة',
                context: context,
                role: widget.role),
            SizedBox(height: 20),
            yearWidget(
                year: 'الرابعة',
                title: 'المرحلة الرابعة',
                context: context,
                role: widget.role),
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

Widget yearWidget(
    {required String year,
    required String title,
    required int role,
    required BuildContext context}) {
  return Center(
    child: InkWell(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return StudentsNamesShow(role, year);
        }));
      },
    ),
  );
}
