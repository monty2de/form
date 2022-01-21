import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                AppButton(
                  title: "تسجيل الدخول",
                  onPressed: () async {
                    UserCredential authResult = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text);

                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();

                    var user = await FirebaseFirestore.instance
                        .collection('students')
                        .where('id', isEqualTo: authResult.user!.uid)
                        .get();
                    if (user.docs.isEmpty) {
                      user = await FirebaseFirestore.instance
                          .collection('teachers')
                          .where('id', isEqualTo: authResult.user!.uid)
                          .get();
                    }

                    user.docs.forEach((data) {
                      sharedPreferences.setInt('role', data.data()['role']);
                      sharedPreferences.setString('id', data.data()['id']);
                      // ignore: unused_local_variable
                      var role = int.parse(
                          sharedPreferences.getInt('role').toString());
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(role: role);
                      }));
                    });
                  },
                ),
                SizedBox(height: 60),
                Row(
                  children: [
                    AppButton(
                      title: 'الاستمرار بدون حساب',
                      width: MediaQuery.of(context).size.width * 0.4,
                      type: ButtonType.secondary,
                      onPressed: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();

                        sharedPreferences.setInt('role', 4);

                        // ignore: unused_local_variable
                        var role = int.parse(
                            sharedPreferences.getInt('role').toString());
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return MyHomePage(role: role);
                        }));
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
}
