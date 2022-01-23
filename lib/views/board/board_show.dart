import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/Controllers/BoardController.dart';
import 'package:form/models/board.dart';
import 'package:form/views/board/board_add_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class BoardShow extends StatefulWidget {
  late int role;
  late String boardName;
final String? position;

  BoardShow(this.role, this.boardName , {this.position});

  @override
  _BoardShowState createState() => _BoardShowState();
}

class _BoardShowState extends State<BoardShow> {

  void sendEmail({
  required String email,
  required String subject,
  required String body,
}) {
  launch("mailto:$email?subject=$subject&body=$body");
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        centerTitle: true,
        title: Text(' الاعضاء'),
        
        actions: [
        
         if (this.widget.boardName == ' اللجنة العلمية') check() else Container()
            

        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: BoardController().index(this.widget.boardName),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return _loading();
                    // ignore: dead_code
                    break;
                  case ConnectionState.waiting:
                    return _loading();
                    // ignore: dead_code
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Container();
                    }
                    if (snapshot.hasData) {
                      return result(snapshot.data, context);
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

  Widget result(List<Board> result, BuildContext context) {


    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(" الاسم"),
          numeric: false,
        ),
       
        DataColumn(
          label: Text(" حذف"),
          numeric: false,
        ),
      ],
      rows: result
          .map(
            (board) => DataRow(
              cells: [
                DataCell(
                  InkWell(
                      child: Text(board.teacherName),
                      onTap: () {
                        if (this.widget.role == 1 ||
                                  this.widget.role == 2) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BoardAddUpdate(
                                      this.widget.role, board:board);
                                }));
                              }
                      }),
                ),
                
                DataCell(
                  InkWell(
                    child: Text('حذف'),
                    onTap: () {
                      if (this.widget.role == 1 || this.widget.role == 2) {
                      BoardController().delet(board.id);

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

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget check() {

    if (this.widget.position == 'تدريسي') {

      return TextButton(
        onPressed: () {
          sendEmail(email: 'moner335555@gmail.com', subject: 'subject', body: 'body');
        },
        child:
            Text(" طلب ترقية  ", style: TextStyle(color: Colors.white)),
        );


      
    }
      
  
    return Container();

  }
}
