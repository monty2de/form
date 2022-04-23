import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/utils/app_button.dart';
import 'package:form/views/login_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var loading = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future _storeUser(
      QuerySnapshot<Map<String, dynamic>> user, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userPass = user.docs.first.data()['pass'];
    if (userPass == passwordController.text)
      user.docs.forEach((data) {
        sharedPreferences.setInt('role', data.data()['role']);
        sharedPreferences.setString('id', data.data()['id']);
        // ignore: unused_local_variable
        var role = int.parse(sharedPreferences.getInt('role').toString());
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return MyHomePage(role: role);
        }), (Route<dynamic> route) => false);
      });
    else
      throw 'The password is invalid';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تسجيل الدخول"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: "الايميل"),
                  controller: emailController,
                ),
                SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(hintText: "الرمز"),
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                loading == 1 ? _loading() : Container(),
                AppButton(
                  title: "تسجيل الدخول",
                  onPressed: () async {
                    setState(() {
                      loading = 1;
                    });
                    try {
                      final student = await FirebaseFirestore.instance
                          .collection(isTestMood ? 'studentsTest' : 'students')
                          .where('email',
                              isEqualTo: emailController.text.trim())
                          .get();
                      if (student.docs.isEmpty) {
                        final teacher = await FirebaseFirestore.instance
                            .collection(
                                isTestMood ? 'teachersTest' : 'teachers')
                            .where('email',
                                isEqualTo: emailController.text.trim())
                            .get();

                        if (teacher.docs.isEmpty) {
                          throw 'User does not exist';
                        }
                        await _storeUser(teacher, context);
                      } else {
                        await _storeUser(student, context);
                      }
                      setState(() {
                        loading = 0;
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        loading = 0;
                      });

                      String message = e.toString();
                      if (message.contains('User does not exist')) {
                        message = 'هذا الحساب غير موجود';
                      } else if (message.contains('The password is invalid')) {
                        message = 'كلمة المرور خطأ';
                      }
                      final snackBar = SnackBar(content: Text(message));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
                SizedBox(height: 60),
                Column(
                  children: [
                    AppButton(
                      title: 'الاستمرار بدون حساب',
                      type: ButtonType.secondary,
                      onPressed: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();

                        sharedPreferences.setInt('role', 4);

                        // ignore: unused_local_variable
                        var role = int.parse(
                            sharedPreferences.getInt('role').toString());
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return MyHomePage(role: role);
                        }), (Route<dynamic> route) => false);
                      },
                    ),
                    AppButton(
                      title: 'انا ادمن',
                      width: MediaQuery.of(context).size.width * 0.4,
                      type: ButtonType.primary,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginAdmin();
                        }));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
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
