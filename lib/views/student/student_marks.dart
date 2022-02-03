import 'package:flutter/material.dart';
import 'package:form/Controllers/ExamResultController.dart';
import 'package:form/Controllers/curriculumController.dart';
import 'package:form/models/examResult.dart';
import 'package:form/views/curriculum/curriculum_add.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class StudentMarks extends StatefulWidget {
late String name;
StudentMarks(this.name);

  @override
  _StudentMarksState createState() => _StudentMarksState();
}

class _StudentMarksState extends State<StudentMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        
        centerTitle: true,
        title: Text('الدرجات'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: ExamResultController().search(this.widget.name),
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

  Widget result(List<ExamResult> result, BuildContext context) {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(label: Text("اسم المادة"), numeric: false),
        DataColumn(label: Text("الدرجة"), numeric: false),
     
      ],
      rows: result
          .map(
            (subject) => DataRow(
              cells: [
                DataCell(Text(subject.subjectName),),
                DataCell(Text(subject.degree)),
                
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
