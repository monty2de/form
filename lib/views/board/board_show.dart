import 'package:flutter/material.dart';
import 'package:form/Controllers/BoardController.dart';
import 'package:form/models/board.dart';
import 'package:form/views/board/board_add_update.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../drawer.dart';

class BoardShow extends StatefulWidget {
  final int role;
  final String boardName;
  final String? position;

  BoardShow(this.role, this.boardName, {this.position});

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
        title: Text('اعضاء ${widget.boardName}'),
        actions: [
          if (widget.boardName == 'اللجنة العلمية') check() else Container()
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: BoardController().index(widget.boardName),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return _loading();

                  case ConnectionState.waiting:
                    return _loading();
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
        DataColumn(label: Text(" الاسم"), numeric: false),
        if (widget.role == 1 || widget.role == 2)
          DataColumn(label: Text(""), numeric: false),
      ],
      rows: result
          .map(
            (board) => DataRow(
              cells: [
                DataCell(
                  Text(board.teacherName),
                  onTap: widget.role == 1 || widget.role == 2
                      ? () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BoardAddUpdate(widget.role, board: board);
                          }));
                        }
                      : null,
                  showEditIcon: widget.role == 1 || widget.role == 2,
                ),
                if (widget.role == 1 || widget.role == 2)
                  DataCell(
                    Text(
                      'حذف',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      BoardController().delet(board.id);
                      setState(() {});
                    },
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
    if (widget.position == 'تدريسي') {
      return TextButton(
        onPressed: () {
          sendEmail(
              email: 'moner335555@gmail.com', subject: 'subject', body: 'body');
        },
        child: Text(" طلب ترقية  ", style: TextStyle(color: Colors.white)),
      );
    }

    return Container();
  }
}
