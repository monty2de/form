import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form/Controllers/NewsController.dart';
import 'package:form/data/arrays.dart';
import 'package:form/data/curriculums.dart';
import 'package:form/data/exams.dart';
import 'package:form/data/students.dart';
import 'package:form/models/news.dart';
import 'package:form/utils/results_wrapper.dart';
import 'package:form/views/news/news_add_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'firebase_options.dart';
// 1=> admin / 2=> teacher / 3=> student / 4=> guest

// over.mind100@gmail.com
// test1234
// حساب مدرس

// test@uot.com
// 12345678
// حساب طالب

// m
// 1
// حساب ادمن

bool isTestMood = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// // students
//   for (var i = 0; i < students.length; i++) {
//     await createStudent(students[i], i);
//   }

//   // curruculums
//   for (var i = 0; i < cs.length; i++) {
//     await curr(cs[i], i);
//   }

//   // exams
//   for (var item in yearArry) {
//     var examYear = FirebaseFirestore.instance
//         .collection(isTestMood ? 'examTableTest' : "examTable")
//         .doc();
//     await examYear.set({
//       'year': item,
//       'id': examYear.id,
//     });
//   }
//   for (var i = 0; i < exams.length; i++) {
//     await examAdd(exams[i], i);
//   }

  final role = await getvalidationData();
  runApp(MyApp(role: role));
}

class MyApp extends StatelessWidget {
  final int role;

  const MyApp({Key? key, this.role = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.light(
            primary: Colors.blue[900]!,
            // secondary: Colors.blue[900]!,
          ),
          primaryColor: Colors.blue[900],
          appBarTheme: AppBarTheme(color: Colors.blue[900])),
      home: MyHomePage(role: role),
      supportedLocales: [Locale('ar', '')],
      localeResolutionCallback: (currentLocale, supportedLocales) {
        return supportedLocales.first;
      },
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

Future<int> getvalidationData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var role = sharedPreferences.getInt('role');

  if (role == null) {
    return 0;
  } else if (role == 1 || role == 2 || role == 3 || role == 4) {
    return role;
  } else {
    return 0;
  }
}

class MyHomePage extends StatefulWidget {
  final int role;

  const MyHomePage({Key? key, this.role = 0}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// ignore: non_constant_identifier_names
  late int role_check;

  @override
  void initState() {
    role_check = widget.role;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(role_check),
      appBar: AppBar(actions: [
        role_check == 1
            ? TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewsAddUpdate(role_check);
                  }));
                },
                child:
                    Text(" اضافة خبر ", style: TextStyle(color: Colors.white)),
              )
            : Container(),
      ], title: Text('الرئيسية'), centerTitle: true),
      body: Column(
        children: [
          Stack(
            children: [
              //               decoration:
              // BoxDecoration(
              //   color: const Color(0xff7c94b6),
              //   image: new DecorationImage(
              //     fit: BoxFit.cover,
              //     colorFilter:
              //       ColorFilter.mode(Colors.black.withOpacity(0.2),
              //       BlendMode.dstATop),
              //     image: new NetworkImage(
              //       'http://www.server.com/image.jpg',
              //     ),
              //   ),
              // ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    image: AssetImage("images/home.jpg"),
                  ),
                ),
              ),
              // Image(

              //   image: AssetImage("images/home.jpg"),
              //   width: MediaQuery.of(context).size.width,
              //   fit: BoxFit.cover,
              //   height: MediaQuery.of(context).size.height * 0.3,
              // ),

              Container(
                margin: const EdgeInsets.only(top: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                        image: AssetImage("images/Logoo2.png"),
                        height: 60,
                        width: 90),
                    Image(
                      image: AssetImage("images/logo1.png"),
                      width: 90,
                      height: 70,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            'اخبار القسم',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Divider(thickness: 2),
          SizedBox(height: 10),
          FutureBuilder(
            future: NewsController().index(),
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
    );
  }

  Widget result(List<News> news, BuildContext context) {
    return checkIfListEmpty(
      dataList: news,
      child: Expanded(
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: news.length,
          itemBuilder: (BuildContext context, int position) {
            return Container(
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.5),
                  borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: this.role_check == 1 || this.role_check == 2
                    ? () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return NewsAddUpdate(
                            role_check,
                            news: news[position],
                          );
                        }));
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          news[position].title,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(height: 15),
                        Text(
                          news[position].body,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                    this.role_check == 1 || this.role_check == 2
                        ? TextButton(
                            child: Text(
                              'حذف',
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                            onPressed: () {
                              NewsController().delet(news[position].id);
                              setState(() {});
                            },
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        ),
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

Future createStudent(Map<String, dynamic> student, int index) async {
  UserCredential? _authResult;
  if (!isTestMood)
    _authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'stEmail$index@temp.com', password: student['pass']);
  try {
    FirebaseFirestore.instance
        .collection(isTestMood ? 'studentsTest' : 'students')
        .doc(_authResult?.user?.uid)
        .set({
      'id': _authResult?.user?.uid ?? '$index',
      'name': student['name'],
      'email': 'stEmail$index@temp.com',
      'sex': student['sex'],
      'BLocation': student['location'],
      'BDate': DateTime(2000).toIso8601String(),
      'location': 'baghdad',
      'year': student['year'],
      'number': student['number'],
      'pass': student['pass'],
      'role': 3,
      'status': student['status'],
      'part': student['part'],
      'shift': student['shift'],
    });
  } on FirebaseAuthException catch (e) {
    print(e.message);
  }
}

Future curr(Map<String, dynamic> curr, int index) async {
  final currs = FirebaseFirestore.instance
      .collection(isTestMood ? 'curriculumTest' : 'curriculum')
      .doc();
  await currs.set({
    'id': currs.id,
    'name': curr['name'],
    'year': curr['year'],
    'type': curr['type'],
    'semister': curr['semister'],
    "units": curr['units'],
  });
}

Future examAdd(Map<String, dynamic> exam, int index) async {
  var year = await FirebaseFirestore.instance
      .collection(isTestMood ? 'examTableTest' : "examTable")
      .where('year', isEqualTo: exam['year'])
      .get();

  var item = FirebaseFirestore.instance
      .collection(isTestMood ? 'examTableTest' : "examTable")
      .doc(year.docs.first.id)
      .collection('Item')
      .doc();
  final date = exam['date'].split('/');
  final dateTime =
      DateTime(int.parse(date[2]), int.parse(date[0]), int.parse(date[1]));
  await item.set({
    'id': item.id,
    'name': exam['name'],
    'date': dateTime.toIso8601String(),
    'year': exam['year'],
    "semister": exam['semister']
  });
}
