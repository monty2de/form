import 'package:flutter/material.dart';
import 'package:form/Controllers/curriculumController.dart';
import 'package:form/models/curriculum.dart';
import 'package:form/views/exam_result/exam_result_add_update.dart';
import 'package:form/views/exam_result/exam_result_show.dart';

import '../../utils/results_wrapper.dart';

class ExamResultSelectYearFirst extends StatelessWidget {
  final int role;
  final String semister;
  const ExamResultSelectYearFirst(
      {Key? key, required this.role, required this.semister})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        actions: [
          this.role <= 2
              ? TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ExamResultAddUpdate(this.role);
                    }));
                  },
                  child: Text("اضافة درجة ",
                      style: TextStyle(color: Colors.white)),
                )
              : Container(),
        ],
        centerTitle: true,
        title: Text('المراحل'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Text(
                '  المرحلة الأولى  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExamResultFirst(role, semister, 'الأولى');
                }));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  المرحلة الثانية  ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExamResultFirst(role, semister, 'الثانية');
                }));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  المرحلة الثالثة   ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExamResultFirst(role, semister, 'الثالثة');
                }));
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                '  المرحلة الرابعة   ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ExamResultFirst(role, semister, 'الرابعة');
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ExamResultFirst extends StatefulWidget {
  final int role;
  final String semister;
  final String year;

  ExamResultFirst(this.role, this.semister, this.year);

  @override
  _ExamResultFirstState createState() => _ExamResultFirstState();
}

class _ExamResultFirstState extends State<ExamResultFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
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
        title: Text('اسماء المواد'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: CurriculumController()
                    .index(1, this.widget.semister, widget.year),
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
      ),
    );
  }

  Widget result(List<Curriculum> curriculum, BuildContext context) {
    print(curriculum.length);
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
