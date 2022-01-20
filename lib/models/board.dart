
class Board {

 
  late String id , name , teacherName  ;



 
  Board({id , name , teacherName  });

  Board.fromFirebase(  var data ){
  
    this.id = data['id'] ;
    this.name = data['name'] ;
    this.teacherName = data['teacherName'] ;

  }

}




          





    