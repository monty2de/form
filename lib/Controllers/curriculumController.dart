import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/main.dart';
import 'package:form/models/curriculum.dart';

class CurriculumController {
  index(
    int type,
    String? semister,
    String? year,
  ) async {
    var curriculumItem = <Curriculum>[];

    var q = FirebaseFirestore.instance
        .collection(isTestMood ? 'curriculumTest' : 'curriculum')
        .where('type', isEqualTo: type)
        .where('semister',
            isEqualTo: semister != 'الأول والثاني' ? null : semister)
        .where('year', isEqualTo: year);
    final d = await q.get();
    print(d.docs.length);
    d.docs.forEach((DocumentSnapshot element) {
      try {
        curriculumItem.add(Curriculum.fromFirebase(element.data()));
      } catch (e) {
        print(e);
      }
    });
    return curriculumItem;
  }

  void delet(String id) async {
    // ignore: unused_local_variable
    var q = await FirebaseFirestore.instance
        .collection(isTestMood ? 'curriculumTest' : 'curriculum')
        .doc(id)
        .delete();
  }
}
