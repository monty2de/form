import 'package:flutter/material.dart';
import 'package:form/Controllers/StudentController.dart';
import 'package:form/models/student.dart';
import 'package:form/views/student/student_update.dart';
import '../../drawer.dart';


// ignore: must_be_immutable
class StudentsNamesShow extends StatefulWidget {

  late int role;
  late int year;

  StudentsNamesShow(this.role , this.year);

  @override
  StudentsNamesShowState createState() => StudentsNamesShowState();
}

class StudentsNamesShowState extends State<StudentsNamesShow> {
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
        title: Text('قائمة الطلاب'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
           FutureBuilder(
            future:   StudentController().index(this.widget.year),
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
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                            SizedBox(height: 15),
                            this.widget.role == 1 || this.widget.role == 2?InkWell(
                              child: Text(
                                'حذف',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              ),
                              onTap: (){
                                StudentController().delet(result[position].id, position);

                               setState(() {
                                 
                               });
                              },
                            ):Container()
                          ],
                        )),
                      ),
                    ],
                  );
                },
              ),
  );
  
}
   
}
