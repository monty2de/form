import 'package:flutter/material.dart';
import 'package:form/Controllers/curriculumController.dart';
import 'package:form/models/curriculum.dart';
import 'package:form/views/curriculum/curriculum_add.dart';
import 'package:form/views/curriculum/curriculum_update.dart';

import '../../drawer.dart';


// ignore: must_be_immutable
class CurriculumFirst extends StatefulWidget {

  late int role;

  CurriculumFirst(this.role);

  @override
  _CurriculumFirstState createState() => _CurriculumFirstState();
}

class _CurriculumFirstState extends State<CurriculumFirst> {
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
      return CurriculumAdd(this.widget.role , 1);
     }));
            },
            child: Text(" اضافة مادة ", style: TextStyle(color: Colors.white)),
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
                                  InkWell(
                                    child: Text(
                                      'اسم المادة:',
                                      style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                    ),
                                    onTap: (){
                                      if (this.widget.role == 1 || this.widget.role == 2) {
                                        

                                        Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                        return CurriculumUpdate(this.widget.role , curriculum[position]);
                                        }));
                                      }
                                    },
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
                                      if (this.widget.role == 1 || this.widget.role == 2) {
                                        

                                        Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                        return CurriculumUpdate(this.widget.role , curriculum[position]);
                                        }));
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
                              ),
                                ],
                              ),

                              this.widget.role == 1 || this.widget.role == 2?InkWell(
                                child: Text(
                                'حذف',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                              ),
                              onTap: (){
                                if (this.widget.role == 1 || this.widget.role == 2) {
                                  CurriculumController().delet(curriculum[position].id);
                                  Navigator.pop(context, false);
                                }
                              },
                              ):Container()


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
