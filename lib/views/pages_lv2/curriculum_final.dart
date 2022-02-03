import 'package:flutter/material.dart';
import 'package:form/Controllers/curriculumController.dart';
import 'package:form/models/curriculum.dart';
import 'package:form/views/curriculum/curriculum_add.dart';

import '../../drawer.dart';

class CurriculumFinal extends StatefulWidget {
  final int role;

  CurriculumFinal(this.role);

  @override
  _CurriculumFinalState createState() => _CurriculumFinalState();
}

class _CurriculumFinalState extends State<CurriculumFinal> {
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
                      return CurriculumAdd(this.widget.role, 2);
                    }));
                  },
                  child: Text("اضافة مادة ",
                      style: TextStyle(color: Colors.white)),
                )
              : Container(),
        ],
        centerTitle: true,
        title: Text('المناهج'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: CurriculumController().index(2),
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
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget result(List<Curriculum> result, BuildContext context) {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(label: Text("الاسم"), numeric: false),
        DataColumn(label: Text("المرحلة"), numeric: false),
        if (this.widget.role == 1 || this.widget.role == 2)
          DataColumn(label: Text(""), numeric: false),
      ],
      rows: result
          .map(
            (subject) => DataRow(
              cells: [
                DataCell(Text(subject.name),
                    onTap: this.widget.role == 1 || this.widget.role == 2
                        ? () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CurriculumAdd(
                                this.widget.role,
                                subject.type,
                                curriculum: subject,
                              );
                            }));
                          }
                        : null),
                DataCell(Text(subject.year)),
                if (this.widget.role == 1 || this.widget.role == 2)
                  DataCell(
                    Text(
                      'حذف',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      CurriculumController().delet(subject.id);
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
