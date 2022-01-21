import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentController {
  var item = <Student>[];

  index(String year) async {
    var q = await FirebaseFirestore.instance
        .collection('students')
        .where('year', isEqualTo: year)
        .get();
    item = [];
    q.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(Student.fromFirebase(data));
    });

    return item;
  }

  show() async {
    var q = await FirebaseFirestore.instance
        .collection('students')
        .where('year', isEqualTo: '6')
        .get();
    var q2 = await FirebaseFirestore.instance
        .collection('students')
        .where('year', isEqualTo: '7')
        .get();
    item = [];
    q.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(Student.fromFirebase(data));
    });

    q2.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(Student.fromFirebase(data));
    });

    return item;
  }

  profile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getInt('role') == 1 ||
        sharedPreferences.getInt('role') == 4) {
      item = [];
      return item;
    } else {
      var id = sharedPreferences.getString('id');
      var user = await FirebaseFirestore.instance
          .collection('students')
          .where('id', isEqualTo: id)
          .get();

      item = [];
      user.docs.forEach((DocumentSnapshot element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        item.add(Student.fromFirebase(data));
      });

      return item;
    }
  }

  search(String name) async {
    var user = await FirebaseFirestore.instance
        .collection('students')
        .where('name', isEqualTo: name)
        .get();

    item = [];
    user.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(Student.fromFirebase(data));
    });

    return item;
  }

  void delet(String id, int position) async {
    print(position);

    // ignore: unused_local_variable
    var q = await FirebaseFirestore.instance
        .collection('students')
        .doc(id)
        .delete();
  }
}
