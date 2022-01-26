import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/views/board/board_add_update.dart';
import 'package:form/views/drawer_pages/about.dart';
import 'package:form/views/drawer_pages/department_activities.dart';
import 'package:form/views/login.dart';
import 'package:form/views/pages_lv2/curriculum_final.dart';
import 'package:form/views/pages_lv2/curriculum_first.dart';
import 'package:form/views/student/student_login.dart';
import 'package:form/views/student/student_show_all.dart';
import 'package:form/views/student/students_name_final_show.dart';
import 'package:form/views/teacher/teacher_add_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'views/board/board_show.dart';
import 'views/pages_lv3/exam_result_final.dart';
import 'views/pages_lv3/exam_result_first.dart';
import 'views/pages_lv3/exam_table_final.dart';
import 'views/pages_lv3/exam_table_first.dart';
import 'views/pages_lv3/students_names_final.dart';
import 'views/pages_lv3/students_names_first.dart';
import 'views/teacher/teacher_show.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final int role;

  NavigationDrawerWidget(this.role);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  Random random = new Random();

  late int randomNumber;

  _NavigationDrawerWidgetState() {
    randomNumber = random.nextInt(512) + 500;
  }
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue[900],
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  buildMenuItem(
                    text: 'الصفحة الرئيسية',
                    onClicked: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(role: widget.role);
                      }), (Route<dynamic> route) => false);
                    },
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: ' نبذة عن القسم ',
                    onClicked: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return About(widget.role);
                      }), (Route<dynamic> route) => false);
                    },
                  ),
                  Divider(thickness: 2),
                  buildMenuItemWithSubCategory(
                    mainCatName: 'لجان القسم',
                    subCategories: [
                      SubCategory(
                        name: 'الدائمة',
                        subCategories: [
                          SubCategory(
                              name: 'اللجنة العلمية',
                              onPressed: () async{
                                if (widget.role == 2) {


                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  var id = sharedPreferences.getString('id');
                                  var user = await FirebaseFirestore.instance.collection('teachers').where('id', isEqualTo: id).get();
                                  var position;
                                  user.docs.forEach((data) {
                                    position = data.data()['position'];
                                  });

                                   
                                  Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BoardShow(
                                      widget.role, ' اللجنة العلمية' , position: position,);
                                }), (Route<dynamic> route) => false);
                                  
                                }else{
                                  Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BoardShow(
                                      widget.role, ' اللجنة العلمية');
                                }), (Route<dynamic> route) => false);
                                }

                                
                              
                              
                              
                              }),
                          SubCategory(
                              name: 'مجلس القسم',
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BoardShow(widget.role, 'مجلس القسم');
                                }), (Route<dynamic> route) => false);
                              }),
                          SubCategory(
                              name: 'لجنة ضمان الجودة',
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BoardShow(
                                      widget.role, 'لجنة ضمان الجودة');
                                }), (Route<dynamic> route) => false);
                              }),
                          SubCategory(
                              name: 'لجنة شؤون الطلبة',
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BoardShow(
                                      widget.role, 'لجنة شؤون الطلبة');
                                }), (Route<dynamic> route) => false);
                              }),
                          //TODO: FIND A BETTER WAY TO DO THIS
                          if (this.widget.role == 1 || this.widget.role == 2)
                            SubCategory(
                                name: 'اضافة عضو جديد',
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BoardAddUpdate(this.widget.role);
                                  }));
                                })
                        ],
                      ),
                      SubCategory(
                          name: 'المؤقتة',
                          onPressed: () {
                            //TODO: Add it later
                          })
                    ],
                  ),
                  Divider(thickness: 2),
                  buildMenuItemWithSubCategory(
                    mainCatName: 'اللجنة الامتحانية',
                    subCategories: [
                      SubCategory(name: 'اولية', subCategories: [
                        SubCategory(
                            name: 'اعضاء اللجنة',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return BoardShow(
                                    widget.role, 'اللجنة الامتحانية- اولية');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: 'اسماء الطلبة',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentsNamesFirst(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: 'جدول الامتحانات',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return ExamTableFirst(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: 'نتائج الطلبة',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return ExamResultFirst(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                      ]),
                      SubCategory(name: 'عليا', subCategories: [
                        SubCategory(
                            name: 'اعضاء اللجنة',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return BoardShow(
                                    widget.role, 'اللجنة الامتحانية-عليا');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: 'اسماء الطلبة',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentsNamesFinal(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: 'جدول الامتحانات',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return ExamTableFinal(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: 'نتائج الطلبة',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return ExamResultFinal(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                      ]),
                    ],
                  ),
                  Divider(thickness: 2),
                  buildMenuItemWithSubCategory(
                      mainCatName: 'كادر القسم',
                      subCategories: [
                        SubCategory(
                            name: 'التدريسين',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherShow(widget.role, 'تدريسي');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: 'مهندسين',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherShow(widget.role, 'مهندس');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: 'منتسبين',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherShow(widget.role, 'منتسب');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: 'خدمات',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherShow(widget.role, 'خدمات');
                              }), (Route<dynamic> route) => false);
                            }),
                        //TODO: FIND A BETTER WAY TO DO THIS
                        if (widget.role == 1)
                          SubCategory(
                              name: 'اضافة عضو جديد',
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return TeacherAddUpdate(widget.role);
                                }));
                              }),
                      ]),
                  Divider(thickness: 2),
                  buildMenuItem(
                    text: 'شؤون الطلبة',
                    onClicked: () {
                      if (widget.role == 1 || widget.role == 2) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return StudentShowAll(widget.role);
                        }), (Route<dynamic> route) => false);
                      } else {

                          
                        Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return StudentLogin();
                      }), (Route<dynamic> route) => false);

                      }
                    },
                  ),
                  Divider(thickness: 2),
                  buildMenuItem(
                    text: 'نشاطات القسم',
                    onClicked: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return Departmentactivities(widget.role);
                      }), (Route<dynamic> route) => false);
                    },
                  ),
                  Divider(thickness: 2),
                  buildMenuItemWithSubCategory(
                    mainCatName: 'المناهج',
                    subCategories: [
                      SubCategory(
                          name: 'اولية',
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return CurriculumFirst(widget.role);
                            }), (Route<dynamic> route) => false);
                          }),
                      SubCategory(
                          name: 'عليا',
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return CurriculumFinal(widget.role);
                            }), (Route<dynamic> route) => false);
                          })
                    ],
                  ),
                  Divider(thickness: 2),
                  buildMenuItemWithSubCategory(
                    mainCatName: 'الدراسات العليا',
                    subCategories: [
                      SubCategory(
                        name: 'المناهج',
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return CurriculumFinal(widget.role);
                          }), (Route<dynamic> route) => false);
                        },
                      ),
                      SubCategory(
                          name: 'الطلبة',
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return StudentsNamesFinalShow(widget.role);
                            }), (Route<dynamic> route) => false);
                          })
                    ],
                  ),
                  Divider(thickness: 2),
                  buildMenuItem(
                    text: 'تسجيل الخروج',
                    onClicked: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      sharedPreferences.clear();
                      // ignore: deprecated_member_use
                      sharedPreferences.commit();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => Login()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    // required IconData icon,
    required VoidCallback onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return Column(
      children: [
        ListTile(
          title: Text(text, style: TextStyle(color: color)),
          hoverColor: hoverColor,
          onTap: onClicked,
        ),
      ],
    );
  }

  Widget buildMenuItemWithSubCategory({
    required String mainCatName,
    required List<SubCategory> subCategories,
  }) {
    final color = Colors.white;
    return ListTile(
      title: Text(mainCatName, style: TextStyle(color: color)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: subCategories
                .map(
                  (e) => e.subCategories == null
                      ? TextButton(
                          onPressed: e.onPressed,
                          child: Text(e.name, style: TextStyle(color: color)),
                        )
                      : buildMenuItemWithSubCategory(
                          mainCatName: e.name, subCategories: e.subCategories!),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class SubCategory {
  final String name;
  final VoidCallback? onPressed;
  final List<SubCategory>? subCategories;

  SubCategory({required this.name, this.onPressed, this.subCategories});
  // : assert(onPressed == null && subCategories == null,
  //       'only one variable should be null not both'),
  //   assert(onPressed != null && subCategories != null,
  //       'only one variable should have a value');
}
