import 'package:flutter/material.dart';
import 'package:form/Controllers/TeacherController.dart';
import 'package:form/models/teacher.dart';
import 'package:form/views/teacher/teacher_update.dart';
import '../../drawer.dart';

// ignore: must_be_immutable
class TeacherShow extends StatefulWidget {
  late int role;
  late String position;

  TeacherShow(this.role, this.position);

  @override
  TeacherShowState createState() => TeacherShowState();
}

class TeacherShowState extends State<TeacherShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        centerTitle: true,
        title: Text('اسماء الكادر '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: TeacherController().index(this.widget.position),
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

  Widget result(List<Teacher> result, BuildContext context) {
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
                              if (this.widget.role == 1) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return TeacherUpdate(
                                      this.widget.role, result[position]);
                                }));
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      this.widget.role == 1
                          ? InkWell(
                              child: Text(
                                'حذف',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              ),
                              onTap: () {
                                TeacherController().delet(result[position].id);

                                setState(() {});
                              },
                            )
                          : Container()
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
