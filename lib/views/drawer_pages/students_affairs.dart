import 'package:flutter/material.dart';
import 'package:form/Controllers/StudentController.dart';
import 'package:form/models/student.dart';
import 'package:form/views/student/student_abscence.dart';
import 'package:form/views/student/student_add_update.dart';
import 'package:form/views/student/student_change_pass.dart';
import 'package:form/views/student/student_marks.dart';
import 'package:form/views/student/student_worn.dart';
import '../../drawer.dart';
import '../../utils/results_wrapper.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
    return checkIfListEmpty(
      dataList: result,
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
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'الاسم: ${result[position].name}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'المرحلة: ${result[position].year}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'رقم الهاتف: ${result[position].number}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: [
                          TapableSquare(
                            title: 'الدرجات',
                            onTab: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentMarks(
                                    result[position].name, this.widget.role);
                              }));
                            },
                          ),
                          TapableSquare(
                            title: 'التبليغات',
                            onTab: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentWorns(
                                    result[position].name, this.widget.role);
                              }));
                            },
                          ),
                          TapableSquare(
                            title: 'تغيير كلمة السر',
                            onTab: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentChangePass(result[position].pass);
                              }));
                            },
                          ),
                          TapableSquare(
                            title: 'تعديل المعلومات',
                            onTab: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentAddUpdate(this.widget.role,
                                    student: result[position]);
                              }));
                            },
                          ),
                          TapableSquare(
                            title: 'الغيابات',
                            onTab: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentAbscece(
                                    result[position].id, widget.role);
                              }));
                            },
                          ),
                          TapableSquare(
                            title: 'المحاضرات',
                            onTab: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
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

class TapableSquare extends StatelessWidget {
  const TapableSquare({
    Key? key,
    required this.title,
    required this.onTab,
  }) : super(key: key);

  final String title;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue[700]),
          ),
        ),
      ),
      onTap: onTab,
    );
  }
}
