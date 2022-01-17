
class ExamTable {

 
  late String id , name , date  ;



 
  ExamTable({id , name , date });

  ExamTable.fromFirebase(  var data ){
  
    this.id = data['id'] ;
    this.name = data['name'] ;
    this.date = data['date'] ;


  }

}




          





    