import 'package:flutter/material.dart';
import 'package:form/Controllers/TeacherController.dart';
import 'package:form/models/teacher.dart';
import 'package:form/views/drawer_pages/students_affairs.dart';
import 'package:form/views/teacher/teacher_add_update.dart';
import 'package:form/views/teacher/teacher_change_pass.dart';
import '../../drawer.dart';
import '../../utils/results_wrapper.dart';

// ignore: must_be_immutable
class TeacherProfile extends StatefulWidget {
  late int role;
  bool isMyprofile;
  String? id;

  TeacherProfile(this.role, {this.isMyprofile = false, this.id});

  @override
  TeacherProfileState createState() => TeacherProfileState();
}

class TeacherProfileState extends State<TeacherProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
          widget.isMyprofile ? NavigationDrawerWidget(this.widget.role) : null,
      appBar: AppBar(
        centerTitle: true,
        title: Text('معلومات الموظف '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future:
                  TeacherController().profile(widget.isMyprofile, widget.id),
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

  Widget result(List<Teacher> results, BuildContext context) {
    final result = results.first;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
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
                    Text(
                      result.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
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
                    Text(
                      result.number,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'البريد الالكتروني:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Text(
                      result.email,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    if (this.widget.role <= 2)
                      TapableSquare(
                        title: 'تعديل المعلومات',
                        onTab: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return TeacherAddUpdate(this.widget.role,
                                teacher: result);
                          }));
                        },
                      ),
                    if (this.widget.role <= 2)
                      TapableSquare(
                        title: 'تغيير كلمة السر',
                        onTab: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return TeacherChangePass(result.pass, result.email);
                          }));
                        },
                      ),
                    TapableSquare(
                      title: 'المحاضرات',
                      onTab: () {},
                    ),
                    TapableSquare(
                      title: 'السيرة الذاتية',
                      onTab: () {},
                    ),
                    TapableSquare(
                      title: 'البحوث الرصينة',
                      onTab: () {},
                    ),
                    TapableSquare(
                      title: 'المحاضرات الفديوية',
                      onTab: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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
