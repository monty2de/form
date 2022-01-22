import 'package:flutter/material.dart';
import 'package:form/Controllers/TeacherController.dart';
import 'package:form/models/teacher.dart';
import 'package:form/views/teacher/teacher_add_update.dart';
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

    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(" الاسم"),
          numeric: false,
        ),
        
        DataColumn(
          label: Text(" حذف"),
          numeric: false,
        ),
      ],
      rows: result
          .map(
            (teacher) => DataRow(
              cells: [
                DataCell(
                  InkWell(
                      child: Text(teacher.name),
                      onTap: () {
                        if (this.widget.role == 1 ) {
                          Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return TeacherAddUpdate(
                                      this.widget.role, teacher: teacher);
                                }));
                        }
                      }),
                ),
                
                DataCell(
                  InkWell(
                    child: Text('حذف'),
                    onTap: () {
                      if (this.widget.role == 1 ) {
                      TeacherController().delet(teacher.id);

                      setState(() {});

                      }
                    },
                  ),
                ),
              ],
            ),
          )
          .toList(),
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
