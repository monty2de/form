import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/models/examResult.dart';
import 'package:form/utils/app_button.dart';

class ExamResultAddUpdate extends StatefulWidget {
  final int role;

  /// Should be passed when updating the curriculum
  final ExamResult? examResult;

  ExamResultAddUpdate(this.role, {this.examResult});

  @override
  ExamResultAddUpdateState createState() => ExamResultAddUpdateState();
}

class ExamResultAddUpdateState extends State<ExamResultAddUpdate> {
  String? yearName;
  String? subjectName;
  String? stName;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController studentNameController;
  late TextEditingController degreeController;

  @override
  void initState() {
    super.initState();
    yearName = widget.examResult?.year;
    studentNameController =
        TextEditingController(text: widget.examResult?.studentName);
    degreeController = TextEditingController(text: widget.examResult?.degree);
  }

  Widget textSection() {
    List<String> yearArry = [
      'عليا اولى',
      'عليا ثانية',
      'الرابعة',
      'الثالثة',
      'الثانية',
      'الاولى',
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم الطالب',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('students').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('error');
              }
              List<String> shubjects = [];
              for (var i = 0; i < snapshot.data!.docs.length; i++) {
                shubjects.add(snapshot.data!.docs[i]['name']);
              }
              return DropdownButtonFormField(
                value: stName,
                items: shubjects.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                enableFeedback: !loading,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintStyle: TextStyle(color: Colors.black),
                ),
                onChanged: (value) {
                  stName = value.toString();
                },
              );
            },
          ),
          SizedBox(height: 10),
          Text(
            'المرحلة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          DropdownButtonFormField<String>(
            value: yearName,
            items: yearArry.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            validator: (value) {
              var temp = value ?? 0;
              if (temp == 0) return 'يجب اختيار المرحلة';
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
                yearName = value;
              });
            },
          ),
          Text(
            ' الدرجة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال  الدرجة';
              return null;
            },
            enabled: !loading,
            controller: degreeController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // icon: Icon(Icons.email, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          Text(
            '  اسم المادة ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('curriculum').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('error');
              }
              List<String> shubjects = [];
              for (var i = 0; i < snapshot.data!.docs.length; i++) {
                shubjects.add(snapshot.data!.docs[i]['name']);
              }
              return DropdownButtonFormField(
                value: subjectName,
                items: shubjects.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                validator: (value) {
                  var temp = value ?? 0;
                  if (temp == 0) return 'يجب اختيار اسم المادة';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text(widget.examResult != null ? 'تعديل درجة' : 'اضافة درجة'),
      ),
      body: Center(
        child: ListView(
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
                    await addNewExamResult(
                        stName!, yearName, degreeController.text, subjectName);
                    setState(() => loading = true);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewExamResult(String studentName, year, degree, subjectName) async {
    //This means that the user is performing an update
    if (widget.examResult != null) {
      if (subjectName == null) {
        subjectName = this.widget.examResult?.subjectName;
      }
      if (year == null) {
        year = this.widget.examResult?.year;
      }

      var subject = FirebaseFirestore.instance
          .collection('examResult')
          .doc(this.widget.examResult!.id);
      await subject.update({
        'id': this.widget.examResult!.id,
        'studentName': studentName,
        'year': year,
        'degree': degree,
        'subjectName': subjectName
      });
      Navigator.pop(context);
      return;
    }
    String id = generateRandomString(32);
    final check =
        await FirebaseFirestore.instance.collection('examResult').doc(id).get();
    if (check.exists) id = generateRandomString(32);

    final orders = FirebaseFirestore.instance.collection('examResult').doc(id);
    await orders.set({
      'id': id,
      'studentName': studentName,
      'year': year,
      'degree': degree,
      'subjectName': subjectName
    });
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
