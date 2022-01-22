import 'package:flutter/material.dart';
import 'package:form/Controllers/ExamTableController.dart';
import 'package:form/models/examTable.dart';
import 'package:form/views/exam_table/exam_table_add_update.dart';
import '../../drawer.dart';

// ignore: must_be_immutable
class ExamTableShow extends StatefulWidget {
  late int role;
  late String year;

  ExamTableShow(this.role, this.year);

  @override
  _ExamTableShowState createState() => _ExamTableShowState();
}

class _ExamTableShowState extends State<ExamTableShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
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
        title: Text('جدول الامتحانات'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: ExamTableController().index(this.widget.year),
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

  Widget result(List<ExamTable> result, BuildContext context) {

    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(" الاسم"),
          numeric: false,
        ),
        DataColumn(
          label: Text(" التاريخ"),
          numeric: false,
        ),
        DataColumn(
          label: Text(" حذف"),
          numeric: false,
        ),
      ],
      rows: result
          .map(
            (table) => DataRow(
              cells: [
                DataCell(
                  InkWell(
                      child: Text(table.name),
                      onTap: () {
                        if (this.widget.role == 1 || this.widget.role == 2) {
                          Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ExamTableAddUpdate(
                                      this.widget.role, examTable: table,);
                                }));
                        }
                      }),
                ),
                DataCell(
                  Text(table.date),
                ),
                DataCell(
                  InkWell(
                    child: Text('حذف'),
                    onTap: () {
                      if (this.widget.role == 1 || this.widget.role == 2) {
                      ExamTableController().delet(
                                    table.id, this.widget.year);

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
