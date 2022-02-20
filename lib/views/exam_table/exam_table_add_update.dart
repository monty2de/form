import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/models/examTable.dart';
import 'package:form/utils/app_button.dart';
import 'package:intl/intl.dart';

class ExamTableAddUpdate extends StatefulWidget {
  final int role;

  /// Should be passed when updating the curriculum
  final ExamTable? examTable;

  ExamTableAddUpdate(this.role, {this.examTable});

  @override
  ExamTableAddUpdateState createState() => ExamTableAddUpdateState();
}

class ExamTableAddUpdateState extends State<ExamTableAddUpdate> {
  String? yearName;
  late var dateStudent;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController nameController;

  @override
  void initState() {
    dateStudent = widget.examTable?.date ?? null;

    super.initState();
    yearName = widget.examTable?.year;
    nameController = TextEditingController(text: widget.examTable?.name);
  }

  Widget textSection() {
    List<String> yearArry = [
      'عليا اولى',
      'عليا ثانية',
      'الرابعة',
      'الثالثة',
      'الثانية',
      'الاولى',
      'غير محدد'
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم المادة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال اسم المادة';
              return null;
            },
            enabled: !loading,
            controller: nameController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // icon: Icon(Icons.email, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: OutlinedButton(
              child: Text(dateStudent != null
                  ? DateFormat.yMMMMEEEEd('ar').format(dateStudent!)
                  : 'التاريخ  '),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: dateStudent ?? DateTime.now(),
                        firstDate: DateTime(1960),
                        lastDate: DateTime(2222))
                    .then((date) {
                  setState(() {
                    dateStudent = date!;
                  });
                });
              },
            ),
          )
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
        title: Text(widget.examTable != null ? 'تعديل ' : 'اضافة '),
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
                    await addNewExamTable(
                        nameController.text, yearName, dateStudent);
                    setState(() => loading = true);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewExamTable(String name, year, date) async {
    //This means that the user is performing an update
    if (widget.examTable != null) {
      if (year == null) {
        year = this.widget.examTable?.year;
      }
      if (date == null) {
        date = this.widget.examTable?.date;
      }

      var id;
      var testExist = await FirebaseFirestore.instance
          .collection('examTable')
          .where('year', isEqualTo: year)
          .get();
      testExist.docs.forEach((data) {
        id = data.data()['id'];
      });

      // ignore: unused_local_variable
      var item = FirebaseFirestore.instance
          .collection('examTable')
          .doc(id)
          .collection('Item')
          .doc(this.widget.examTable?.id)
          .update({
        'id': this.widget.examTable?.id,
        'name': name,
        'date': date,
        'year': year,
      });

      Navigator.pop(context);
      return;
    }

    var id;
    var testExist = await FirebaseFirestore.instance
        .collection('examTable')
        .where('year', isEqualTo: year)
        .get();
    if (testExist.docs.isEmpty) {
      id = generateRandomString(32);

      var check = await FirebaseFirestore.instance
          .collection('examTable')
          .doc(id)
          .get();
      if (check.exists) {
        id = generateRandomString(32);
      }

      var examYear = FirebaseFirestore.instance.collection('examTable').doc(id);
      await examYear.set({
        'id': id,
        'year': year,
      });
    } else {
      testExist.docs.forEach((data) {
        id = data.data()['id'];
      });
    }
    // ignore: non_constant_identifier_names
    var id_for_item = generateRandomString(32);
    // ignore: unused_local_variable
    var item = FirebaseFirestore.instance
        .collection('examTable')
        .doc(id)
        .collection('Item')
        .doc(id_for_item)
        .set({
      'id': id_for_item,
      'name': name,
      'date': date,
      'year': year,
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
