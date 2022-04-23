import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/main.dart';
import 'package:form/models/board.dart';
import 'package:form/utils/app_button.dart';

class BoardAddUpdate extends StatefulWidget {
  final int role;

  /// Should be passed when updating the curriculum
  final Board? board;

  BoardAddUpdate(this.role, {this.board});

  @override
  BoardAddUpdateState createState() => BoardAddUpdateState();
}

class BoardAddUpdateState extends State<BoardAddUpdate> {
  String? teacherName;
  String? boardName;
  String? isBoss;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController nameController;
  late TextEditingController yearController;

  @override
  void initState() {
    super.initState();
    teacherName = widget.board?.teacherName;
    boardName = widget.board?.name;
    isBoss = widget.board?.isBoss;
  }

  Widget textSection() {
    var positionarray = [
      ' اللجنة العلمية',
      'مجلس القسم',
      'لجنة ضمان الجودة',
      'لجنة شؤون الطلبة',
      'اللجنة الامتحانية- اولية',
      'اللجنة الامتحانية-عليا'
    ];
    var msqarray = [
      'نعم',
      'كلا',
    ];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم العضو',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(isTestMood ? 'teachersTest' : 'teachers')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('error');
              }
              List<String> shubjects = [];
              for (var i = 0; i < snapshot.data!.docs.length; i++) {
                shubjects.add(snapshot.data!.docs[i]['name']);
              }
              return DropdownButtonFormField(
                value: teacherName,
                items: shubjects.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                validator: (value) {
                  var temp = value ?? 0;
                  if (temp == 0) return 'يجب اختيار اسم العضو';
                  return null;
                },
                enableFeedback: !loading,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // icon: Icon(Icons.stacked_bar_chart, color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                ),
                onChanged: (value) {
                  teacherName = value.toString();
                },
              );
            },
          ),
          SizedBox(height: 10),
          Text(
            'اسم اللجنة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          DropdownButtonFormField<String>(
            value: boardName,
            items: positionarray.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            validator: (value) {
              var temp = value ?? 0;
              if (temp == 0) return 'يجب اختيار اسم اللجنة';
              return null;
            },
            enableFeedback: !loading,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // icon: Icon(Icons.stacked_bar_chart, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) {
              setState(() {
                boardName = value;
              });
            },
          ),
          SizedBox(height: 10),
          Text(
            ' رئيس اللجنة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          DropdownButtonFormField<String>(
            value: isBoss,
            items: msqarray.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            validator: (value) {
              var temp = value ?? 0;
              if (temp == 0) return 'يجب اختيار اسم اللجنة';
              return null;
            },
            enableFeedback: !loading,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // icon: Icon(Icons.stacked_bar_chart, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) {
              setState(() {
                isBoss = value;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.board != null ? 'تعديل عضو' : 'اضافة عضو'),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: textSection(),
            ),
            AppButton(
                loading: loading,
                onPressed: () async {
                  setState(() => loading = true);
                  if (_formKey.currentState!.validate()) {
                    await addNewBoard(boardName!, teacherName, isBoss);
                    setState(() => loading = true);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewBoard(String boardName, teacherName, isboss) async {
    //This means that the user is performing an update
    if (widget.board != null) {
      if (teacherName == null) {
        teacherName = this.widget.board?.teacherName;
      }
      var item = FirebaseFirestore.instance
          .collection(isTestMood ? 'boardsTest' : 'boards')
          .doc(this.widget.board!.id);
      await item.update({
        'id': this.widget.board!.id,
        'name': boardName,
        'teacherName': teacherName,
        'isBoss': isBoss,
      });
      Navigator.pop(context);
      return;
    }

    var checkDouble = await FirebaseFirestore.instance
        .collection(isTestMood ? 'boardsTest' : 'boards')
        .where('name', isEqualTo: boardName)
        .where('teacherName', isEqualTo: teacherName)
        .get();
    if (checkDouble.docs.isNotEmpty) {
      Navigator.pop(context);
      return;
    }

    final orders = FirebaseFirestore.instance
        .collection(isTestMood ? 'boardsTest' : 'boards')
        .doc();
    await orders.set({
      'id': orders.id,
      'name': boardName,
      'teacherName': teacherName,
      'isBoss': isBoss,
    });
    Navigator.pop(context);
  }
}
