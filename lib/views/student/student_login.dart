import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/utils/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../drawer.dart';
import '../../main.dart';

class StudentLogin extends StatefulWidget {
  final int role;
  StudentLogin(this.role);
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  var loading = 0;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
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
                      UserCredential authResult = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text);

                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();

                      var user = await FirebaseFirestore.instance
                          .collection(isTestMood ? 'studentsTest' : 'students')
                          .where('id', isEqualTo: authResult.user!.uid)
                          .get();

                      setState(() {
                        loading = 0;
                      });
                      user.docs.forEach((data) {
                        sharedPreferences.setInt('role', data.data()['role']);
                        sharedPreferences.setString('id', data.data()['id']);
                        sharedPreferences.setString(
                            'email', data.data()['email']);
                        // ignore: unused_local_variable
                        var role = int.parse(
                            sharedPreferences.getInt('role').toString());

                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return MyHomePage(role: role);
                        }), (Route<dynamic> route) => false);
                      });
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        loading = 0;
                      });

                      var message = e.message;

                      if (message ==
                          'There is no user record corresponding to this identifier. The user may have been deleted.') {
                        message = 'هذا الحساب غير موجود';
                      } else if (message ==
                          'The password is invalid or the user does not have a password.') {
                        message = 'كلمة المرور خطأ';
                      }
                      final snackBar = SnackBar(content: Text(message!));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
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
