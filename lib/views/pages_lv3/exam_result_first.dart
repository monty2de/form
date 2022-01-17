import 'package:flutter/material.dart';
import 'package:form/Controllers/curriculumController.dart';
import 'package:form/models/curriculum.dart';
import 'package:form/views/pages_lv4/exam_result_show.dart';

import '../../drawer.dart';
import '../curriculum_add.dart';
import '../exam_result_add.dart';


class ExamResultFirst extends StatefulWidget {

  late int role;

  ExamResultFirst(this.role);

  @override
  _ExamResultFirstState createState() => _ExamResultFirstState();
}

class _ExamResultFirstState extends State<ExamResultFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(

        actions: [

          this.widget.role == 1 ? FlatButton(
            onPressed: () {
             
             
             
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ExamResultAdd(this.widget.role , 1 )), (Route<dynamic> route) => false);
            },
            child: Text(" اضافة درجة ", style: TextStyle(color: Colors.white)),
          ) :Container(),
        ],
        centerTitle: true,
        title: Text('المناهج'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            FutureBuilder(
            future:   curriculumController().index(1),
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


   Widget Result( List<curriculum> curriculum , BuildContext context ){

    
  return Expanded(
    child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: curriculum.length,
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
                                curriculum[position].name,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),

                              onTap: (){

                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ExamResultShow(this.widget.role , curriculum[position].name )), (Route<dynamic> route) => false);


                              },
                            ),
                            SizedBox(height: 15),
                            Text(
                              curriculum[position].year,
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
