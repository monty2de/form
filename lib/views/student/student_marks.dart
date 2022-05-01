import 'package:flutter/material.dart';
import 'package:form/Controllers/ExamResultController.dart';
import 'package:form/models/examResult.dart';
import 'package:form/views/exam_result/exam_result_add_update.dart';
import 'package:form/views/exam_result/exam_result_show.dart';

import '../../utils/results_wrapper.dart';

// ignore: must_be_immutable
class StudentMarks extends StatefulWidget {
  late String name;
  late int role;
  late String? year;

  StudentMarks(this.name, this.role, this.year);

  @override
  _StudentMarksState createState() => _StudentMarksState();
}

class _StudentMarksState extends State<StudentMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('الدرجات'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                        print(snapshot.error);
                        return Container();
                      }
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            result(snapshot.data, context),
                            SizedBox(height: 10),
                            if (widget.year == 'الرابعة')
                              Text(getAvarage(snapshot.data))
                          ],
                        );
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
      ),
    );
  }

  Widget result(List<ExamResult> result, BuildContext context) {
    return checkIfListEmpty(
      dataList: result,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(label: Text("اسم المادة"), numeric: false),
          DataColumn(label: Text("الفصل الدراسي"), numeric: false),
          DataColumn(label: Text("الدرجة"), numeric: false),
        ],
        rows: result
            .map(
              (subject) => DataRow(
                cells: [
                  DataCell(Text(subject.subjectName!),
                      onTap: widget.role <= 2
                          ? () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ExamResultAddUpdate(
                                  this.widget.role,
                                  examResult: subject,
                                );
                              }));
                            }
                          : null),
                  DataCell(Text(subject.semister!)),
                  if (this.widget.role <= 2)
                    DataCell(Text(subject.finalDegree!)),
                  if (this.widget.role > 2)
                    DataCell(Text(getFinalDegreeText(subject.finalDegree!))),
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

String getAvarage(List<ExamResult> results) {
  if (results.isNotEmpty)
    return "المعدل: ${(results.fold<int>(0, (a, b) => a + int.parse(b.finalDegree ?? '0')) / results.length)}";
  return 'المعدل: 0';
}
