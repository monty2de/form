import 'package:flutter/material.dart';
import 'package:form/data/arrays.dart';
import 'package:form/views/exam_result/exam_result_add_update.dart';
import 'package:form/views/exam_result/exam_result_first.dart';

import '../../drawer.dart';
import '../../utils/results_wrapper.dart';

class ShowSemisterFirst extends StatefulWidget {
  final int role;

  ShowSemisterFirst(this.role);

  @override
  _ShowSemisterFirstState createState() => _ShowSemisterFirstState();
}

class _ShowSemisterFirstState extends State<ShowSemisterFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        actions: [
          this.widget.role <= 2
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
        title: Text('الفصل الدراسي '),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: result(semisterArry, context),
        ),
      ),
    );
  }

  Widget result(List<String> semister, BuildContext context) {
    return checkIfListEmpty(
      dataList: semister,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(label: Text("الكورس"), numeric: false),
        ],
        rows: semister
            .map(
              (subject) => DataRow(
                cells: [
                  DataCell(Text(subject), onTap: () {
                    print(subject);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ExamResultFirst(this.widget.role, subject);
                    }));
                  }),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
