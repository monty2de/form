import 'package:flutter/material.dart';
import 'package:form/Controllers/ExamResultController.dart';
import 'package:form/Controllers/ExamTableController.dart';
import 'package:form/models/examResult.dart';
import 'package:form/models/examTable.dart';


import '../../drawer.dart';
import '../exam_table_add.dart';


// ignore: must_be_immutable
class ExamResultShow extends StatefulWidget {

  late int role;
  late String subjectName;
  ExamResultShow(this.role , this.subjectName);

  @override
  _ExamResultShowState createState() => _ExamResultShowState();
}

class _ExamResultShowState extends State<ExamResultShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(

        actions: [

          this.widget.role == 1 ? FlatButton(
            onPressed: () {
             
             
             
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ExamTableAdd(this.widget.role )), (Route<dynamic> route) => false);
            },
            child: Text(" اضافة  ", style: TextStyle(color: Colors.white)),
          ) :Container(),
        ],
        centerTitle: true,
        title: Text('النتائج'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
           FutureBuilder(
            future:   ExamResultController().index(this.widget.subjectName),
            builder: ( BuildContext context , AsyncSnapshot snapshot ){
    
              switch ( snapshot.connectionState ){
    
                
                case ConnectionState.done :
                  if(snapshot.hasError){
                    return Container();
                  }
                  if(snapshot.hasData){
                    return Result(snapshot.data , context);
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

Widget Result( List<ExamResult> ExamResult , BuildContext context ){

    
  return Expanded(
    child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ExamResult.length,
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
                            Text(
                              ExamResult[position].studentName,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 15),
                            Text(
                              ExamResult[position].degree,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
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
