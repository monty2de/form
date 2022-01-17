import 'package:flutter/material.dart';
import 'package:form/Controllers/curriculumController.dart';
import 'package:form/models/curriculum.dart';

import '../../drawer.dart';
import '../curriculum_add.dart';


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

        actions: [

          this.widget.role == 1 ? FlatButton(
            onPressed: () {
             
             
             
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => CurriculumAdd(this.widget.role , 1)), (Route<dynamic> route) => false);
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
                            Text(
                              curriculum[position].name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
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
