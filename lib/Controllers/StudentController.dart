import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/models/student.dart';

class StudentController   {

  
  var item = <Student>[];



   index(int year) async {


    var q  = await FirebaseFirestore.instance.collection('students').where('year' , isEqualTo: year.toString()).get();
    item = [];
    q.docs.forEach((DocumentSnapshot element) {
        
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(Student.fromFirebase(data));


    });

    return item;

  }


  void delet(String id , int position) async{
    print(position);

    // ignore: unused_local_variable
    var q  = await FirebaseFirestore.instance.collection('students').doc(id).delete() ;

  }





}
