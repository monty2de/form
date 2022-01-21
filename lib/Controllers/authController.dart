class AuthController {
// void login(String email, String password) async {
//     try {

//       UserCredential authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email.trim(), password: password);

//       // print(authResult.user!.uid);
//       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//       var user = await FirebaseFirestore.instance.collection('students').where('id' , isEqualTo:authResult.user!.uid ).get();

//                   user.docs.forEach((data) {
//                       sharedPreferences.setInt('role', data.data()['role']);
//                         var role =int.parse(sharedPreferences.getInt('role').toString());
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return MyHomePage( role  );
//                       }));

//                   });

//     } catch (e) {

//     }
//   }

}
