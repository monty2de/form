
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/Controllers/authController.dart';
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
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: "username"),
                controller: emailController,
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                controller: passwordController,
                obscureText: true,
              ),
              ElevatedButton(
                child: Text("Log In"),
                onPressed: () {
                 
                },
              ),
              
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextButton(
                  child: Text("i'm admin"),
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


