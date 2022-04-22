import 'package:flutter/material.dart';
import 'package:form/Controllers/StudentController.dart';
import 'package:form/models/student.dart';
import 'package:form/views/student/student_add_update.dart';
import 'package:form/views/student/student_add_worn.dart';
import 'package:form/views/student/students_names_first.dart';
import '../../drawer.dart';
import '../../utils/results_wrapper.dart';

class StudentShowAll extends StatefulWidget {
  final int role;

  StudentShowAll(this.role);

  @override
  StudentShowAllState createState() => StudentShowAllState();
}

class StudentShowAllState extends State<StudentShowAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        actions: [
          this.widget.role == 1 || this.widget.role == 2
              ? PopupMenuButton(
                  // add icon, by default "3 dot" icon
                  // icon: Icon(Icons.book)
                  itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text("اضافة طالب"),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Text("اضافة تبليغ"),
                    ),
                  ];
                }, onSelected: (value) {
                  if (value == 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StudentAddUpdate(widget.role);
                    }));
                  } else if (value == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WornAdd();
                    }));
                  }
                })
              : Container(),
        ],
        centerTitle: true,
        title: Text('قائمة الطلاب'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              yearWidget(
                  year: 'الأولى',
                  title: 'المرحلة الأولى',
                  context: context,
                  role: widget.role),
              SizedBox(height: 20),
              yearWidget(
                  year: 'الثانية',
                  title: 'المرحلة الثانية',
                  context: context,
                  role: widget.role),
              SizedBox(height: 20),
              yearWidget(
                  year: 'الثالثة',
                  title: 'المرحلة الثالثة',
                  context: context,
                  role: widget.role),
              SizedBox(height: 20),
              yearWidget(
                  year: 'الرابعة',
                  title: 'المرحلة الرابعة',
                  context: context,
                  role: widget.role),
              SizedBox(height: 20),
              yearWidget(
                  year: 'عليا اولى',
                  title: 'عليا اولى',
                  context: context,
                  role: widget.role),
              SizedBox(height: 20),
              yearWidget(
                  year: 'عليا ثانية',
                  title: 'عليا ثانية',
                  context: context,
                  role: widget.role),
              SizedBox(height: 20),
              yearWidget(
                  year: 'غير محدد',
                  title: 'غير محدد',
                  context: context,
                  role: widget.role),
            ],
          ),
        ),
      ),
    );
  }

  Widget result(List<Student> result, BuildContext context) {
    return checkIfListEmpty(
      dataList: result,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(label: Text("الاسم"), numeric: false),
          DataColumn(label: Text("المرحلة"), numeric: false),
          if (this.widget.role == 1 || this.widget.role == 2)
            DataColumn(label: Text(""), numeric: false),
        ],
        rows: result
            .map(
              (student) => DataRow(
                cells: [
                  DataCell(
                    Text(student.name),
                    onTap: this.widget.role == 1 || this.widget.role == 2
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return StudentAddUpdate(this.widget.role,
                                    student: student);
                              }),
                            );
                          }
                        : null,
                  ),
                  DataCell(Text(student.year)),
                  if (this.widget.role == 1 || this.widget.role == 2)
                    DataCell(
                      Text('حذف', style: TextStyle(color: Colors.red)),
                      onTap: () {
                        if (this.widget.role == 1 || this.widget.role == 2) {
                          StudentController().delet(student.id);

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
