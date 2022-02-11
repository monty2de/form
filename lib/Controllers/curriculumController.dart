import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/models/curriculum.dart';

class CurriculumController {
  var curriculumItem = <Curriculum>[];

  index(int type, String semister) async {
    if (semister == '') {

      var q = await FirebaseFirestore.instance
          .collection('curriculum')
          .where('type', isEqualTo: type)
          .get();
      curriculumItem = [];
      q.docs.forEach((DocumentSnapshot element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        curriculumItem.add(Curriculum.fromFirebase(data));
      });

      return curriculumItem;
    } else {



      var q = await FirebaseFirestore.instance
          .collection('curriculum')
          .where('type', isEqualTo: type).where('semister', isEqualTo: semister).get();
          
      curriculumItem = [];
      q.docs.forEach((DocumentSnapshot element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        curriculumItem.add(Curriculum.fromFirebase(data));
      });

      return curriculumItem;
    }
  }

  void delet(String id) async {
    // ignore: unused_local_variable
    var q = await FirebaseFirestore.instance
        .collection('curriculum')
        .doc(id)
        .delete();
  }
}
