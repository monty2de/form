import 'package:flutter/material.dart';
import 'package:form/Controllers/StudentController.dart';
import 'package:form/models/student.dart';
import 'package:form/views/student/student_add_update.dart';
import '../../drawer.dart';


// ignore: must_be_immutable
class SearchStudent extends StatefulWidget {

  late int role;
  late String name;

  SearchStudent(this.role , this.name);

  @override
  SearchStudentState createState() => SearchStudentState();
}

class SearchStudentState extends State<SearchStudent> {
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
        title: Text('النتائج '),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            
           FutureBuilder(
            future:   StudentController().search(this.widget.name),
            builder: ( BuildContext context , AsyncSnapshot snapshot ){
    
              switch ( snapshot.connectionState ){
                
                case ConnectionState.active :
                          return _loading();
                          // ignore: dead_code
                          break;
                        case ConnectionState.waiting :
                          return _loading();
                          // ignore: dead_code
                          break;
                
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


  return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(" الاسم"),
          numeric: false,
        ),
        DataColumn(
          label: Text(" المرحلة"),
          numeric: false,
        ),
        DataColumn(
          label: Text(" حذف"),
          numeric: false,
        ),
      ],
      rows: result
          .map(
            (student) => DataRow(
              cells: [
                DataCell(
                  InkWell(
                      child: Text(student.name),
                      onTap: () {
                        if (this.widget.role == 1 || this.widget.role == 2) {
                          Navigator.push(context, MaterialPageRoute( builder:  ( context ){
                                  return StudentAddUpdate(this.widget.role ,  student: student);
                                  } )); 
                        }
                      }),
                ),
                DataCell(
                  Text(student.year),
                ),
                DataCell(
                  InkWell(
                    child: Text('حذف'),
                    onTap: () {
                      if (this.widget.role == 1 || this.widget.role == 2) {
                      StudentController().delet(student.id);

                      setState(() {});

                      }
                    },
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );

    
 
  
}
   Widget _loading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
