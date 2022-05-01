import 'package:flutter/material.dart';
import 'package:form/Controllers/StudentController.dart';
import 'package:form/drawer.dart';
import 'package:form/models/absence.dart';
import 'package:form/views/student/student_abscence_add.dart';
import 'package:intl/intl.dart';

import '../../utils/results_wrapper.dart';

// ignore: must_be_immutable
class StudentAbscece extends StatefulWidget {
  late String? id;
  late int role;
  StudentAbscece(this.id, this.role);

  @override
  _StudentAbsceceState createState() => _StudentAbsceceState();
}

class _StudentAbsceceState extends State<StudentAbscece> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
          widget.id != null ? null : NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        centerTitle: true,
        title: Text('الغيابات'),
        actions: [
          this.widget.role == 1 || this.widget.role == 2
              ? TextButton(
                  onPressed: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AbscenceAdd();
                    }));
                    setState(() {});
                  },
                  child: Text("اضافة غياب ",
                      style: TextStyle(color: Colors.white)),
                )
              : Container(),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: StudentController().abscences(this.widget.id),
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

  Widget result(List<Abscence> result, BuildContext context) {
    return checkIfListEmpty(
      dataList: result,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
              label: Expanded(child: Text("اسم الطالب")), numeric: false),
          DataColumn(label: Text("المرحلة"), numeric: false),
          DataColumn(label: Text("المادة"), numeric: false),
          DataColumn(label: Text("التاريخ"), numeric: false),
          if (widget.role <= 2) DataColumn(label: Text(""), numeric: false),
        ],
        rows: result
            .map(
              (subject) => DataRow(
                cells: [
                  DataCell(Text(subject.stName)),
                  DataCell(Text(subject.year)),
                  DataCell(Text(subject.subject)),
                  DataCell(
                      Text(DateFormat.yMMMMEEEEd('ar').format(subject.date))),
                  if (this.widget.role <= 2)
                    DataCell(
                      Text('حذف', style: TextStyle(color: Colors.red)),
                      onTap: () {
                        {
                          StudentController().abdDelete(subject.id);
                          setState(() {});
                        }
                      },
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
