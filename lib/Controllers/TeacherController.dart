import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/main.dart';
import 'package:form/models/teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherController {
  var item = <Teacher>[];

  index(String position) async {
    var q = await FirebaseFirestore.instance
        .collection(isTestMood ? 'teachersTest' : 'teachers')
        .where('position', isEqualTo: position)
        .get();
    item = [];
    q.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      try {
        item.add(Teacher.fromFirebase(data));
      } catch (e) {
        print(e);
      }
    });

    return item;
  }

  void delet(String id) async {
    // ignore: unused_local_variable
    var q = await FirebaseFirestore.instance
        .collection(isTestMood ? 'teachersTest' : 'teachers')
        .doc(id)
        .delete();
  }

  profile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var id = sharedPreferences.getString('id');
    var user = await FirebaseFirestore.instance
        .collection(isTestMood ? 'teachersTest' : 'teachers')
        .where('id', isEqualTo: id)
        .get();

    item = [];
    user.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      try {
        item.add(Teacher.fromFirebase(data));
      } catch (e) {
        print(e);
      }
    });

    return item;
  }
}
