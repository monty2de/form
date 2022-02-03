import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/utils/app_button.dart';
import 'package:form/views/login_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../drawer.dart';
import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
 var loading = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
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
                loading == 1? _loading():Container(),
                AppButton(
                  title: "تسجيل الدخول",
                  onPressed: () async {
                   late UserCredential authResult;
                   setState(() {
                        loading = 1;
                      });
                    try {
                      
                       authResult = await FirebaseAuth.instance
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
                    setState(() {
                        loading = 0;
                      });

                    user.docs.forEach((data) {
                      sharedPreferences.setInt('role', data.data()['role']);
                      sharedPreferences.setString('id', data.data()['id']);
                      // ignore: unused_local_variable
                      var role = int.parse(
                          sharedPreferences.getInt('role').toString());
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(role: role);
                      }), (Route<dynamic> route) => false);
                    });
                      
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                      setState(() {
                        loading =0;
                      });
             
                      var message = e.message;
                      if (message == 'There is no user record corresponding to this identifier. The user may have been deleted.') {
                        message = 'هذا الحساب غير موجود';
                        
                      }else if (message == 'The password is invalid or the user does not have a password.') {
                        message = 'كلمة المرور خطأ';
                      }
                      final snackBar = SnackBar(
                         content:  Text(message!));
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
