import 'package:flutter/material.dart';
import 'package:form/Controllers/StudentController.dart';
import 'package:form/models/student.dart';
import 'package:form/views/student/student_add_update.dart';
import 'package:form/views/student/student_change_pass.dart';
import 'package:form/views/student/student_marks.dart';
import 'package:form/views/student/student_worn.dart';
import '../../drawer.dart';

// ignore: must_be_immutable
class StudentsAffairs extends StatefulWidget {
  late int role;

  StudentsAffairs(this.role);

  @override
  StudentsAffairsState createState() => StudentsAffairsState();
}

class StudentsAffairsState extends State<StudentsAffairs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        centerTitle: true,
        title: Text('معلومات الطالب '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: StudentController().profile(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return _loading();
                    // ignore: dead_code
                    break;
                  case ConnectionState.waiting:
                    return _loading();
                    // ignore: dead_code
                    break;

                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Container();
                    }
                    if (snapshot.hasData) {
                      return result(snapshot.data, context);
                    }
                    break;
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    break;
                  case ConnectionState.active:
                    break;
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget result(List<Student> result, BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (BuildContext context, int position) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            'الاسم:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          InkWell(
                            child: Text(
                              result[position].name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            onTap: () {
                              if (this.widget.role == 1 ||
                                  this.widget.role == 2) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return StudentAddUpdate(
                                      this.widget.role, student: result[position],);
                                }));
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'المرحلة:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          InkWell(
                            child: Text(
                              result[position].year,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            onTap: () {
                              if (this.widget.role == 1 ||
                                  this.widget.role == 2) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return StudentAddUpdate(
                                      this.widget.role, student: result[position]);
                                }));
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'رقم الهاتف:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          InkWell(
                            child: Text(
                              result[position].number,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            onTap: () {
                              if (this.widget.role == 1 ||
                                  this.widget.role == 2) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return StudentAddUpdate(
                                      this.widget.role, student: result[position],);
                                }));
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        child: Text(
                          'تعديل المعلومات',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StudentAddUpdate(
                                this.widget.role, student: result[position]);
                          }));
                        },
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        child: Text(
                          ' تغيير كلمة السر',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StudentChangePass(
                                result[position].pass);
                          }));
                        },
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        child: Text(
                          '   الدرجات',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[300]),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StudentMarks(
                                result[position].name , this.widget.role);
                          }));
                        },
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        child: Text(
                          '   التبليغات',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[300]),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StudentWorns(
                                result[position].name , this.widget.role);
                          }));
                        },
                      ),
                    ],
                  ),
                )),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
