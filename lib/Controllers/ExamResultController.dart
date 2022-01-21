import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/models/examResult.dart';

class ExamResultController {
  var item = <ExamResult>[];

  index(String subjName) async {
    var q = await FirebaseFirestore.instance
        .collection('examResult')
        .where('subjectName', isEqualTo: subjName)
        .get();
    item = [];
    q.docs.forEach((DocumentSnapshot element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(ExamResult.fromFirebase(data));
    });

    return item;
  }

  void delet(String id) async {
    // ignore: unused_local_variable
    var q = await FirebaseFirestore.instance
        .collection('examResult')
        .doc(id)
        .delete();
  }
}
