import 'package:flutter/material.dart';
import 'package:form/Controllers/ExamResultController.dart';
import 'package:form/models/examResult.dart';
import 'package:form/views/exam_result/exam_result_add_update.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class ExamResultShow extends StatefulWidget {
  late int role;
  late String subjectName;
  ExamResultShow(this.role, this.subjectName);

  @override
  _ExamResultShowState createState() => _ExamResultShowState();
}

class _ExamResultShowState extends State<ExamResultShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        centerTitle: true,
        title: Text('النتائج'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: ExamResultController().index(this.widget.subjectName),
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

  Widget result(List<ExamResult> result, BuildContext context) {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(label: Text(" الاسم"), numeric: false),
        DataColumn(label: Text(" الدرجة"), numeric: false),
        if (this.widget.role == 1 || this.widget.role == 2)
          DataColumn(label: Text(""), numeric: false),
      ],
      rows: result
          .map(
            (examresult) => DataRow(
              cells: [
                DataCell(Text(examresult.studentName),
                    onTap: this.widget.role == 1 || this.widget.role == 2
                        ? () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ExamResultAddUpdate(
                                this.widget.role,
                                examResult: examresult,
                              );
                            }));
                          }
                        : null),
                DataCell(Text(examresult.degree)),
                if (this.widget.role == 1 || this.widget.role == 2)
                  DataCell(
                    Text(
                      'حذف',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      ExamResultController().delet(examresult.id);
                      setState(() {});
                    },
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
