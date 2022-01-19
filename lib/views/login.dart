
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: "الايميل"),
                controller: emailController,
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "الرمز"),
                controller: passwordController,
                obscureText: true,
              ),
              ElevatedButton(
                child: Text(" تسجيل الدخول"),
                onPressed: () async{
                 UserCredential authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailController.text.trim(), password: passwordController.text);
    
      
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                var user = await FirebaseFirestore.instance.collection('students').where('id' , isEqualTo:authResult.user!.uid ).get();

                  user.docs.forEach((data) {
                      sharedPreferences.setInt('role', data.data()['role']);
                        // ignore: unused_local_variable
                        var role =int.parse(sharedPreferences.getInt('role').toString());
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage( );
                      }));
                    
                  });

                },
              ),
              
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextButton(
                  child: Text(" انا ادمن"),
                  onPressed: () {
                    
                    Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginAdmin();
                      }));
                  },
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}


