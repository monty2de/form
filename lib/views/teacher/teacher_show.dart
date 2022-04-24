import 'package:flutter/material.dart';
import 'package:form/Controllers/TeacherController.dart';
import 'package:form/models/teacher.dart';
import 'package:form/views/teacher/teacher_add_update.dart';
import 'package:form/views/teacher/teacher_profile.dart';
import '../../drawer.dart';
import '../../utils/results_wrapper.dart';

class TeacherShow extends StatefulWidget {
  final int role;
  final String position;

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
        title: Text('اسماء الكادر'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: TeacherController().index(this.widget.position),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return _loading();

                    case ConnectionState.waiting:
                      return _loading();

                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Container();
                      }
                      if (snapshot.hasData) {
                        return result(snapshot.data, context);
                      }
                      break;
                    case ConnectionState.none:
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget result(List<Teacher> result, BuildContext context) {
    return checkIfListEmpty(
      dataList: result,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(label: Text("الاسم"), numeric: false),
          if (this.widget.role == 1)
            DataColumn(label: Text(""), numeric: false),
        ],
        rows: result
            .map(
              (teacher) => DataRow(
                cells: [
                  DataCell(Text(teacher.name),
                      onTap: this.widget.role == 1
                          ? () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherAddUpdate(this.widget.role,
                                    teacher: teacher);
                              }));
                            }
                          : () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherProfile(3, id: teacher.id);
                              }));
                            }),
                  if (this.widget.role == 1)
                    DataCell(
                      InkWell(
                        child: Text('حذف', style: TextStyle(color: Colors.red)),
                        onTap: () {
                          TeacherController().delet(teacher.id);
                          setState(() {});
                        },
                      ),
                    ),
                ],
              ),
            )
            .toList(),
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
