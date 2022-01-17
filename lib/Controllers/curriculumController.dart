import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/models/curriculum.dart';
import 'package:form/models/news.dart';

class curriculumController   {

  
  var curriculumItem = <curriculum>[];



   index(int type) async {


    var q  = await FirebaseFirestore.instance.collection('curriculum').where('type' , isEqualTo: type).get();
    curriculumItem = [];
    q.docs.forEach((DocumentSnapshot element) {
        
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      curriculumItem.add(curriculum.fromFirebase(data));


    });

    return curriculumItem;

  }





}
