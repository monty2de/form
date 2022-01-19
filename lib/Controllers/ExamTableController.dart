import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/models/examTable.dart';

class ExamTableController   {

  
  var item = <ExamTable>[];



   index(int year) async {


    var q  = await FirebaseFirestore.instance.collection('examTable').where('year' , isEqualTo: year.toString()).get();
    var id;
    q.docs.forEach((data) {           
      id = data.data()['id']   ;
    });
   
    q  = await FirebaseFirestore.instance.collection('examTable').doc(id).collection('Item').get();
    item = [];
    q.docs.forEach((DocumentSnapshot element) {
        
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;

      item.add(ExamTable.fromFirebase(data));


    });

    return item;

  }


  void delet(String idItem , int year  ) async{


    // ignore: unused_local_variable
    var q1  = await FirebaseFirestore.instance.collection('examTable').where('year' , isEqualTo: year.toString()).get();
    var id;
    q1.docs.forEach((data) {           
      id = data.data()['id']   ;
    });

   
   var q  = await FirebaseFirestore.instance.collection('examTable').doc(id).collection('Item').doc(idItem).delete();

  }





}
