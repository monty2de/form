import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/data/arrays.dart';
import 'package:form/main.dart';
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
  String? semisterName;
  String? subjectName;

  late DateTime? dateStudent;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    yearName = widget.examTable?.year;
    dateStudent = widget.examTable?.date ?? null;

    semisterName = widget.examTable?.semister;
    subjectName = widget.examTable?.name;
  }

  Widget textSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
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
                subjectName = null;
                yearName = value;
              });
            },
          ),
          SizedBox(height: 10),
          Text(
            'الفصل الدراسي',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          DropdownButtonFormField<String>(
            value: semisterName,
            items: semisterArry.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            validator: (value) {
              var temp = value ?? 0;
              if (temp == 0) return 'يجب اختيار الفصل الدراسي';
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
                semisterName = value;
              });
            },
          ),
          if (semisterName != null && yearName != null)
            Text(
              '  اسم المادة ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          if (semisterName != null && yearName != null)
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(isTestMood ? 'curriculumTest' : 'curriculum')
                  .where('year', isEqualTo: yearName)
                  .where('semister', isEqualTo: semisterName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('loading..');
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
          SizedBox(height: 10),
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
                    await addNewExamTable(subjectName!, yearName,
                        dateStudent?.toIso8601String(), semisterName);
                  }
                  setState(() => loading = false);
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewExamTable(String name, year, date, semisterName) async {
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
          .collection(isTestMood ? 'examTableTest' : 'examTable')
          .where('year', isEqualTo: year)
          .get();
      testExist.docs.forEach((data) {
        id = data.data()['id'];
      });

      // ignore: unused_local_variable
      var item = FirebaseFirestore.instance
          .collection(isTestMood ? 'examTableTest' : 'examTable')
          .doc(id)
          .collection('Item')
          .doc(this.widget.examTable?.id)
          .update({
        'id': this.widget.examTable?.id,
        'name': name,
        'date': date,
        'year': year,
        "semister": semisterName
      });

      Navigator.pop(context);
      return;
    }

    String? id;
    var yearExist = await FirebaseFirestore.instance
        .collection(isTestMood ? 'examTableTest' : 'examTable')
        .where('year', isEqualTo: year)
        .get();
    if (yearExist.docs.isEmpty) {
      var examYear = FirebaseFirestore.instance
          .collection(isTestMood ? 'examTableTest' : 'examTable')
          .doc();
      await examYear.set({
        'year': year,
        'id': examYear.id,
      });
    } else {
      id = yearExist.docs.first.data()['id'];
    }

    var item = FirebaseFirestore.instance
        .collection(isTestMood ? 'examTableTest' : 'examTable')
        .doc(id)
        .collection('Item')
        .doc();

    await item.set({
      'id': item.id,
      'name': name,
      'date': date,
      'year': year,
      "semister": semisterName
    });

    Navigator.pop(context);
  }
}
