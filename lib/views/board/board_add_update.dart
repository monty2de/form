import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController nameController;
  late TextEditingController yearController;

  @override
  void initState() {
    super.initState();
    teacherName = widget.board?.teacherName;
    boardName = widget.board?.name;
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم العضو',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('teachers').snapshots(),
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
                    await addNewBoard(boardName!, teacherName);
                    setState(() => loading = true);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewBoard(String boardName, teacherName) async {
    //This means that the user is performing an update
    if (widget.board != null) {
      if (teacherName == null) {
        teacherName = this.widget.board?.teacherName;
      }
      var item = FirebaseFirestore.instance
          .collection('boards')
          .doc(this.widget.board!.id);
      await item.update({
        'id': this.widget.board!.id,
        'name': boardName,
        'teacherName': teacherName
      });
      Navigator.pop(context);
      return;
    }

    var checkDouble = await FirebaseFirestore.instance
    .collection('boards')
    .where('name', isEqualTo: boardName).where('teacherName', isEqualTo: teacherName)
    .get();
    if (checkDouble.docs.isNotEmpty) {
      Navigator.pop(context);
      return;
    }

    String id = generateRandomString(32);
    final check =
        await FirebaseFirestore.instance.collection('boards').doc(id).get();
    if (check.exists) id = generateRandomString(32);

    final orders = FirebaseFirestore.instance.collection('boards').doc(id);
    await orders.set({'id': id, 'name': boardName, 'teacherName': teacherName});
    Navigator.pop(context);
  }

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
