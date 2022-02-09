import 'package:flutter/material.dart';
import 'package:form/Controllers/curriculumController.dart';
import 'package:form/models/curriculum.dart';
import 'package:form/views/exam_result/exam_result_add_update.dart';
import 'package:form/views/exam_result/exam_result_show.dart';

import '../../drawer.dart';
import '../../utils/results_wrapper.dart';

class ExamResultFirst extends StatefulWidget {
  final int role;

  ExamResultFirst(this.role);

  @override
  _ExamResultFirstState createState() => _ExamResultFirstState();
}

class _ExamResultFirstState extends State<ExamResultFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        actions: [
          this.widget.role == 1 || this.widget.role == 2
              ? TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ExamResultAddUpdate(this.widget.role);
                    }));
                  },
                  child: Text(" اضافة درجة ",
                      style: TextStyle(color: Colors.white)),
                )
              : Container(),
        ],
        centerTitle: true,
        title: Text('اسماء المواد'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: CurriculumController().index(1),
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

  Widget result(List<Curriculum> curriculum, BuildContext context) {
    return checkIfListEmpty(
      dataList: curriculum,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(label: Text("المادة"), numeric: false),
          DataColumn(label: Text("المرحلة"), numeric: false),
        ],
        rows: curriculum
            .map(
              (subject) => DataRow(
                cells: [
                  DataCell(Text(subject.name), onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ExamResultShow(this.widget.role, subject.name);
                    }));
                  }),
                  DataCell(Text(subject.year)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
