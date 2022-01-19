
class Curriculum {

 
  late String id , name , year  ;
  late int type;


 
  Curriculum({id , name , year , type });

  Curriculum.fromFirebase(  var data ){
  
    this.id = data['id'] ;
    this.name = data['name'] ;
    this.year = data['year'] ;
    this.type = data['type'] ;

  }

}




          





    