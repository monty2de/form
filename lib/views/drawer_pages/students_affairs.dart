import 'package:flutter/material.dart';
import 'package:form/Controllers/StudentController.dart';
import 'package:form/models/student.dart';
import 'package:form/views/student/student_update.dart';
import '../../drawer.dart';


// ignore: must_be_immutable
class StudentsAffairs extends StatefulWidget {

  late int role;


  StudentsAffairs(this.role );

  @override
  StudentsAffairsState createState() => StudentsAffairsState();
}

class StudentsAffairsState extends State<StudentsAffairs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(

        leading: IconButton(icon: Icon(Icons.arrow_back_ios ,  ),
        onPressed:() {
          Navigator.pop(context, false);
        },
      ),
          
        
        centerTitle: true,
        title: Text('معلومات الطالب '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
           FutureBuilder(
            future:   StudentController().profile(),
            builder: ( BuildContext context , AsyncSnapshot snapshot ){
    
              switch ( snapshot.connectionState ){
    
                
                case ConnectionState.done :
                  if(snapshot.hasError){
                    return Container();
                  }
                  if(snapshot.hasData){
                    return result(snapshot.data , context);
                  }
                  break;
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  break;
                case ConnectionState.active:
                  break;
              }
              return Container();
            },
          ),
            
          ],
        ),
      ),
    );
  }

Widget result( List<Student> result , BuildContext context ){

    
  return Expanded(
    child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: result.length,
                itemBuilder: (BuildContext context, int position) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 30),
                        child: Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top:10),
                              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Row(
                                children: [

                                  Text(
                                  'الاسم:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                  InkWell(
                                child: Text(
                                  result[position].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),

                                onTap: (){
                                  if (this.widget.role == 1 || this.widget.role == 2) {
                                    Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                                  return StudentsUpdate(this.widget.role ,  result[position]);
                                  } )); 
                                  }
                                                               
                                  },
                              ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [

                                  Text(
                                  'المرحلة:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                  InkWell(
                                child: Text(
                                  result[position].year,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),

                                onTap: (){
                                  if (this.widget.role == 1 || this.widget.role == 2) {
                                    Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                                  return StudentsUpdate(this.widget.role ,  result[position]);
                                  } )); 
                                  }
                                                               
                                  },
                              ),
                                ],
                              ),

                              SizedBox(height: 15),
                              Row(
                                children: [

                                  Text(
                                  'رقم الهاتف:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                  InkWell(
                                child: Text(
                                  result[position].number,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),

                                onTap: (){
                                  if (this.widget.role == 1 || this.widget.role == 2) {
                                    Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                                  return StudentsUpdate(this.widget.role ,  result[position]);
                                  } )); 
                                  }
                                                               
                                  },
                              ),
                                ],
                              ),
                              SizedBox(height: 15),
                              InkWell(
                                child: Text(
                                  'تعديل المعلومات',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red),
                                ),

                                onTap: (){
                                 
                                    Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                                  return StudentsUpdate(this.widget.role ,  result[position]);
                                  } )); 
                                  
                                                               
                                  },
                              ),
                              
                          ],
                        ),
                            )),
                      ),
                    ],
                  );
                },
              ),
  );
  
}
   
}
