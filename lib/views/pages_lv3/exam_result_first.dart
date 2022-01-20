import 'package:flutter/material.dart';
import 'package:form/Controllers/curriculumController.dart';
import 'package:form/models/curriculum.dart';
import 'package:form/views/exam_result/exam_result_add.dart';
import 'package:form/views/exam_result/exam_result_show.dart';

import '../../drawer.dart';


// ignore: must_be_immutable
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

        
        leading: IconButton(icon: Icon(Icons.arrow_back_ios ,  ),
        onPressed:() {
          Navigator.pop(context, false);
        },
      ),

        actions: [

          this.widget.role == 1 || this.widget.role == 2 ? TextButton(
            onPressed: () {
             
             Navigator.push(context,
      MaterialPageRoute(builder: (context) {
      return ExamResultAdd(this.widget.role , 1 );
     }));
             
            },
            child: Text(" اضافة درجة ", style: TextStyle(color: Colors.white)),
          ) :Container(),
        ],
        centerTitle: true,
        title: Text('اسماء المواد'),

        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            FutureBuilder(
            future:   CurriculumController().index(1),
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


   Widget result( List<Curriculum> curriculum , BuildContext context ){

    
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
                            child: Container(
                              margin: const EdgeInsets.only(top:10),
                              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                               Row(
                                children: [
                                  Text(
                                  'المادة:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),

                                  InkWell(
                                child: Text(
                                  curriculum[position].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),

                                onTap: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                  return ExamResultShow(this.widget.role , curriculum[position].name );
                                  }));


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
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(
                                curriculum[position].year,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              )
                                ],
                              )
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
