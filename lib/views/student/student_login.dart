import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/utils/app_button.dart';
import 'package:form/views/drawer_pages/students_affairs.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StudentLogin extends StatefulWidget {
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
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

                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                    var user = await FirebaseFirestore.instance
                        .collection('students')
                        .where('id', isEqualTo: authResult.user!.uid)
                        .get();
                    

                    user.docs.forEach((data) {
                      sharedPreferences.setInt('role', data.data()['role']);
                      sharedPreferences.setString('id', data.data()['id']);
                      // ignore: unused_local_variable
                      var role = int.parse(sharedPreferences.getInt('role').toString());

                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return StudentsAffairs(role);
                      }), (Route<dynamic> route) => false);
                    });
                  },
                ),
               
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
