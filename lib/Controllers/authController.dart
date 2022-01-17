
import 'package:cloud_firestore/cloud_firestore.dart';



class AuthController  {

 

void login(String username, String password) async {
    try {

      var admins = await FirebaseFirestore.instance.collection('admins').get();

                  admins.docs.forEach((data) {
                    if (data.data()['id'] != username.trim() ) {
                     print(data.data()['id']);
                      print('id wronge');
                    }else if(data.data()['password'] != password.trim()){
                      print('pass wronge');
                    }
                    else {
                      // role = data.data()['role'] ;
                      // go to home page
                    }
                  });



    } catch (e) {
      
    }
  }
  


  
}
