import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/views/board/board_add_update.dart';
import 'package:form/views/curriculum/curriculum_final.dart';
import 'package:form/views/curriculum/curriculum_first.dart';
import 'package:form/views/drawer_pages/about.dart';
import 'package:form/views/drawer_pages/department_activities.dart';
import 'package:form/views/drawer_pages/students_affairs.dart';
import 'package:form/views/exam_result/exam_result_semister_final.dart';
import 'package:form/views/exam_result/exam_result_semister_first.dart';
import 'package:form/views/exam_table/exam_table_final.dart';
import 'package:form/views/exam_table/exam_table_first.dart';
import 'package:form/views/login.dart';
import 'package:form/views/student/student_abscence.dart';
import 'package:form/views/student/student_show_all.dart';
import 'package:form/views/student/students_name_final_show.dart';
import 'package:form/views/student/students_names_final.dart';
import 'package:form/views/student/students_names_first.dart';
import 'package:form/views/teacher/teacher_add_update.dart';
import 'package:form/views/teacher/teacher_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'views/board/board_show.dart';

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
        color: Colors.white70,
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  buildMenuItem(
                    text: '???????????? ????????????????',
                    onClicked: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(role: widget.role);
                      }), (Route<dynamic> route) => false);
                    },
                  ),
                  const SizedBox(height: 24),
                  if (widget.role == 5 || widget.role == 4)
                    buildMenuItem(
                      text: '?????????? ????????????',
                      onClicked: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }), (Route<dynamic> route) => false);
                      },
                    ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: ' ???????? ???? ?????????? ',
                    onClicked: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return About(widget.role);
                      }), (Route<dynamic> route) => false);
                    },
                  ),
                  // if (widget.role == 2)
                  //   buildMenuItem(
                  //     text: '?????????????? ????????????',
                  //     onClicked: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return TeacherProfile(this.widget.role,
                  //             isMyprofile: true);
                  //       }));
                  //     },
                  //   ),
                  buildMenuItemWithSubCategory(
                    mainCatName: '???????? ??????????',
                    subCategories: [
                      SubCategory(
                        name: '??????????????',
                        subCategories: [
                          SubCategory(
                              name: '???????????? ??????????????',
                              onPressed: () async {
                                if (widget.role == 2) {
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  var id = sharedPreferences.getString('id');
                                  var user = await FirebaseFirestore.instance
                                      .collection(isTestMood
                                          ? 'teachersTest'
                                          : 'teachers')
                                      .where('id', isEqualTo: id)
                                      .get();
                                  var position;
                                  user.docs.forEach((data) {
                                    position = data.data()['position'];
                                  });
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BoardShow(
                                        widget.role, ' ???????????? ??????????????',
                                        position: position);
                                  }), (Route<dynamic> route) => false);
                                } else {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BoardShow(
                                        widget.role, ' ???????????? ??????????????');
                                  }), (Route<dynamic> route) => false);
                                }
                              }),
                          SubCategory(
                              name: '???????? ??????????',
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BoardShow(widget.role, '???????? ??????????');
                                }), (Route<dynamic> route) => false);
                              }),
                          SubCategory(
                              name: '???????? ???????? ????????????',
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BoardShow(
                                      widget.role, '???????? ???????? ????????????');
                                }), (Route<dynamic> route) => false);
                              }),
                          SubCategory(
                              name: '???????? ???????? ????????????',
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BoardShow(
                                      widget.role, '???????? ???????? ????????????');
                                }), (Route<dynamic> route) => false);
                              }),
                          if (this.widget.role <= 2)
                            SubCategory(
                                name: '?????????? ?????? ????????',
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BoardAddUpdate(this.widget.role);
                                  }));
                                })
                        ],
                      ),
                      SubCategory(
                          name: '??????????????',
                          onPressed: () {
                            //TODO: Add it later
                          })
                    ],
                  ),
                  buildMenuItemWithSubCategory(
                    mainCatName: '???????????? ????????????????????',
                    subCategories: [
                      SubCategory(name: '??????????', subCategories: [
                        SubCategory(
                            name: '?????????? ????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return BoardShow(
                                    widget.role, '???????????? ????????????????????- ??????????');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: '?????????? ????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentsNamesFirst(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: '???????? ????????????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return ExamTableFirst(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: '?????????? ????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return ShowSemisterFirst(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                      ]),
                      SubCategory(name: '????????', subCategories: [
                        SubCategory(
                            name: '?????????? ????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return BoardShow(
                                    widget.role, '???????????? ????????????????????-????????');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: '?????????? ????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentsNamesFinal(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: '???????? ????????????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return ExamTableFinal(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: '?????????? ????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return ShowSemisterFinal(widget.role);
                              }), (Route<dynamic> route) => false);
                            }),
                      ]),
                    ],
                  ),
                  buildMenuItemWithSubCategory(
                      mainCatName: '???????? ??????????',
                      subCategories: [
                        SubCategory(
                            name: '??????????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherShow(widget.role, '????????????');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: '??????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherShow(widget.role, '??????????');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: '??????????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherShow(widget.role, '??????????');
                              }), (Route<dynamic> route) => false);
                            }),
                        SubCategory(
                            name: '??????????',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return TeacherShow(widget.role, '??????????');
                              }), (Route<dynamic> route) => false);
                            }),
                        if (widget.role == 1)
                          SubCategory(
                              name: '?????????? ?????? ????????',
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return TeacherAddUpdate(widget.role);
                                }));
                              }),
                      ]),
                  buildMenuItem(
                    text: '???????? ????????????',
                    onClicked: () {
                      if (widget.role <= 2) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return StudentShowAll(widget.role);
                        }), (Route<dynamic> route) => false);
                      } else {
                        if (widget.role <= 2) {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }), (Route<dynamic> route) => false);
                        } else {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return StudentsAffairs(widget.role);
                          }), (Route<dynamic> route) => false);
                        }
                      }
                    },
                  ),
                  buildMenuItem(
                    text: '???????????? ????????????',
                    onClicked: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return StudentAbscece(null, widget.role);
                      }), (Route<dynamic> route) => false);
                    },
                  ),
                  buildMenuItem(
                    text: '???????????? ??????????',
                    onClicked: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return Departmentactivities(widget.role);
                      }), (Route<dynamic> route) => false);
                    },
                  ),
                  buildMenuItemWithSubCategory(
                    mainCatName: '??????????????',
                    subCategories: [
                      SubCategory(
                          name: '??????????',
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return CurriculumFirst(widget.role);
                            }), (Route<dynamic> route) => false);
                          }),
                      SubCategory(
                          name: '????????',
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return CurriculumFinal(widget.role);
                            }), (Route<dynamic> route) => false);
                          })
                    ],
                  ),
                  buildMenuItemWithSubCategory(
                    mainCatName: '???????????????? ????????????',
                    subCategories: [
                      SubCategory(
                        name: '??????????????',
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return CurriculumFinal(widget.role);
                          }), (Route<dynamic> route) => false);
                        },
                      ),
                      SubCategory(
                          name: '????????????',
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return StudentsNamesFinalShow(widget.role);
                            }), (Route<dynamic> route) => false);
                          })
                    ],
                  ),
                  if (widget.role != 0 && widget.role != 4)
                    buildMenuItem(
                      text: '?????????? ????????????',
                      onClicked: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();

                        sharedPreferences.clear();
                        // ignore: deprecated_member_use
                        sharedPreferences.commit();
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }), (Route<dynamic> route) => false);
                      },
                    )
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
    final color = Colors.blue[900];

    return Column(
      children: [
        ListTile(
          title: Text(text, style: TextStyle(color: color)),
          onTap: onClicked,
        ),
      ],
    );
  }

  Widget buildMenuItemWithSubCategory({
    required String mainCatName,
    required List<SubCategory> subCategories,
  }) {
    final color = Colors.blue[900];
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(mainCatName, style: TextStyle(color: color)),
      expandedAlignment: Alignment.centerRight,
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
