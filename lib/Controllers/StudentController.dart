import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/main.dart';
import 'package:form/models/absence.dart';
import 'package:form/models/student.dart';
import 'package:form/models/worn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentController {
  var item = <Student>[];

  index(String year) async {
    var q = await FirebaseFirestore.instance
        .collection(isTestMood ? 'studentsTest' : 'students')
        .where('year', isEqualTo: year)
        .get();
    item = [];
    q.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(Student.fromFirebase(data));
    });

    return item;
  }

  all() async {
    try {
      var q = await FirebaseFirestore.instance
          .collection(isTestMood ? 'studentsTest' : 'students')
          .get();
      item = [];
      q.docs.forEach((DocumentSnapshot element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        item.add(Student.fromFirebase(data));
      });

      return item;
    } catch (e) {
      print(e);
    }
  }

  show() async {
    var q = await FirebaseFirestore.instance
        .collection(isTestMood ? 'studentsTest' : 'students')
        .where('year', isEqualTo: 'عليا اولى')
        .get();
    var q2 = await FirebaseFirestore.instance
        .collection(isTestMood ? 'studentsTest' : 'students')
        .where('year', isEqualTo: 'عليا ثانية')
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

  profile(String? sId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // if (sharedPreferences.getInt('role') == 1 ||
    //     sharedPreferences.getInt('role') == 4) {
    //   item = [];
    //   return item;
    // } else {
    var id = sId ?? sharedPreferences.getString('id');
    var user = await FirebaseFirestore.instance
        .collection(isTestMood ? 'studentsTest' : 'students')
        .where('id', isEqualTo: id)
        .get();

    item = [];
    user.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(Student.fromFirebase(data));
    });

    return item;
    // }
  }

  search(String name) async {
    var user = await FirebaseFirestore.instance
        .collection(isTestMood ? 'studentsTest' : 'students')
        .where('name', isGreaterThanOrEqualTo: name)
        .get();

    item = [];
    user.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(Student.fromFirebase(data));
    });

    return item;
  }

  worn(String stName) async {
    var user = await FirebaseFirestore.instance
        .collection(isTestMood ? 'wornsTest' : 'worns')
        .where('stname', isEqualTo: stName)
        .get();

    var item2 = <Worn>[];
    user.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item2.add(Worn.fromFirebase(data));
    });

    return item2;
  }

  Future<List<Abscence>> abscences(String? id) async {
    var x = FirebaseFirestore.instance
        .collection(isTestMood ? 'abscencesTest' : 'abscences')
        .where('stId', isEqualTo: id);

    final ab = await x.get();
    print(ab.docs.length);
    var item2 = <Abscence>[];
    ab.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      try {
        item2.add(Abscence.fromfirebase(data));
      } catch (e) {
        print(e);
      }
    });

    return item2;
  }

  void abdDelete(String id) async {
    await FirebaseFirestore.instance
        .collection(isTestMood ? 'abscencesTest' : 'abscences')
        .doc(id)
        .delete();
  }

  void delet(String id) async {
    // ignore: unused_local_variable
    var q = await FirebaseFirestore.instance
        .collection(isTestMood ? 'studentsTest' : 'students')
        .doc(id)
        .delete();
  }
}
