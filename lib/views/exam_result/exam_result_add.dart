import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExamResultAdd extends StatefulWidget {
  late int role;
  late int type;

  ExamResultAdd(this.role, this.type);

  @override
  ExamResultAddState createState() => ExamResultAddState();
}

class ExamResultAddState extends State<ExamResultAdd> {
  var subjectName;
  var yearName;

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  var globalKey = GlobalKey<FormState>();

  late TextEditingController studentNameController =
      new TextEditingController();
  late TextEditingController yearController = new TextEditingController();
  late TextEditingController degreeController = new TextEditingController();

  Future store(String studentName, year, degree, subjectName) async {
    var id = generateRandomString(32);

    var check =
        await FirebaseFirestore.instance.collection('examResult').doc(id).get();
    if (check.exists) {
      id = generateRandomString(32);
    }

    var orders = FirebaseFirestore.instance.collection('examResult').doc(id);
    await orders.set({
      'id': id,
      'studentName': studentName,
      'year': year,
      'degree': degree,
      'subjectName': subjectName
    });

    Navigator.pop(context, false);
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.only(left: 120, right: 120),
      margin: EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
        onPressed: () {
          if (globalKey.currentState!.validate()) {
            store(studentNameController.text, yearController.text,
                degreeController.text, subjectName);
          }
        },
        child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  Container textSection() {
    var yearArry = [
      'عليا اولى',
      'عليا ثانية',
      'الخامسة',
      'الرابعة',
      'الثالثة',
      'الثانية',
      ' الاولى'
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم الطالب',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال العنوان';
              return null;
            },
            controller: studentNameController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              icon: Icon(Icons.email, color: Colors.white70),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          Text(
            '  المرحلة ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          DropdownButtonFormField(
            items: yearArry.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              yearName = value;
            },
          ),
          Text(
            '  الدرجة ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال  الدرجة';
              return null;
            },
            controller: degreeController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              icon: Icon(Icons.email, color: Colors.white70),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          Text(
            '  اسم المادة ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('curriculum')
                .where('type', isEqualTo: this.widget.type)
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
                items: shubjects.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  subjectName = value.toString();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            title: Text('اضافة درجة')),
        body: Form(
          key: globalKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              textSection(),
              // buttonSection(),

              ElevatedButton(
                onPressed: () {
                  if (globalKey.currentState!.validate()) {
                    store(studentNameController.text, yearName,
                        degreeController.text, subjectName);
                  }
                },
                child: Text(" حفظ", style: TextStyle(color: Colors.white70)),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ],
          ),
        ),
      );
}
