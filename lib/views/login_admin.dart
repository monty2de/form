import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class LoginAdmin extends StatefulWidget {

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
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
                onPressed: () async{

                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  var admins = await FirebaseFirestore.instance.collection('admins').get();

                  admins.docs.forEach((data) {
                    if (data.data()['id'] != emailController.text.trim() ) {
                     print(data.data()['id']);
                      print('id wronge');
                    }else if(data.data()['password'] != passwordController.text.trim()){
                      print('pass wronge');
                    }
                    else {
                      sharedPreferences.setInt('role', data.data()['role']);
                        var role =int.parse(sharedPreferences.getInt('role').toString());
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MyHomePage(   );
                      }));
                    }
                  });
                  
                },
              ),
              
             
              
            ],
          ),
        ),
      ),
    );
  }
}


