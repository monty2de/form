import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/models/teacher.dart';

class TeacherController   {

  
  var item = <Teacher>[];



  index(String position) async {


  var q  = await FirebaseFirestore.instance.collection('teachers').where('position' , isEqualTo: position).get();
  item = [];
  q.docs.forEach((DocumentSnapshot element) {
      
    Map<String, dynamic> data = element.data() as Map<String, dynamic>;

    item.add(Teacher.fromFirebase(data));


  });

  return item;

}


  


  void delet(String id ) async{

    // ignore: unused_local_variable
    var q  = await FirebaseFirestore.instance.collection('teachers').doc(id).delete() ;

  }





}
