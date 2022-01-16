// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'main.dart';




class AuthController extends GetxController {

  


  
  void login(String username, String password) async {
    try {

      var admins = await FirebaseFirestore.instance.collection('admins').get();

                  admins.docs.forEach((data) {
                    if (data.data()['id'] != username.trim() ) {
                      // Scaffold.of(context).showSnackBar(SnackBar(content: Text('wrong id'))  );
                      // ScaffoldMessenger.showSnackBar(SnackBar(content: Text('wrong id')));
                      print('id wronge');
                    }else if(data.data()['password'] != password.trim()){
                      print('pass wronge');
                    }
                    else {
                      Get.to(MyHomePage());
                    }
                  });



    } catch (e) {
      
    }
  }

  
}
