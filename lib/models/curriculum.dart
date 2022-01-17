
class curriculum {

 
  late String id , name , year  ;
  late int type;


 
  curriculum({id , name , year , type });

  curriculum.fromFirebase(  var data ){
  
    this.id = data['id'] ;
    this.name = data['name'] ;
    this.year = data['year'] ;
    this.type = data['type'] ;

  }

}




          





    