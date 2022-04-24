import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/data/arrays.dart';
import 'package:form/main.dart';
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
  String? semisterName;
  String? subjectName;
  String? stName;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController studentNameController;
  late TextEditingController degreeController;
  late TextEditingController semesterDegreeController;
  late TextEditingController finalDegreeController;
  late TextEditingController avaregeDegreeController;

  @override
  void initState() {
    super.initState();
    yearName = widget.examResult?.year;
    semisterName = widget.examResult?.semister;
    subjectName = widget.examResult?.subjectName;
    stName = widget.examResult?.studentName;
    semesterDegreeController =
        TextEditingController(text: widget.examResult?.semersterDegree);
    finalDegreeController =
        TextEditingController(text: widget.examResult?.finalDegree);
    avaregeDegreeController =
        TextEditingController(text: widget.examResult?.finalDegree);
    studentNameController =
        TextEditingController(text: widget.examResult?.studentName);
    degreeController = TextEditingController(text: widget.examResult?.degree);
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
                yearName = value;
              });
            },
          ),
          if (yearName != null)
            Text(
              'اسم الطالب',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          if (yearName != null)
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(isTestMood ? 'studentsTest' : 'students')
                  .where('year', isEqualTo: yearName)
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
          Text(
            'درجة الدفتر',
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
            'السعي',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال الدرجة';
              return null;
            },
            enabled: !loading,
            controller: semesterDegreeController,
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
            'الدرجة النهائية',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال الدرجة';
              return null;
            },
            enabled: !loading,
            controller: finalDegreeController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // icon: Icon(Icons.email, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          if (yearName == 'الرابعة')
            Text(
              'المعدل',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          if (yearName == 'الرابعة')
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) return 'يجب ادخال الدرجة';
                return null;
              },
              enabled: !loading,
              controller: avaregeDegreeController,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                // icon: Icon(Icons.email, color: Colors.black),
                hintStyle: TextStyle(color: Colors.black),
              ),
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
                        stName!,
                        yearName,
                        degreeController.text,
                        subjectName,
                        semisterName,
                        semesterDegreeController.text,
                        finalDegreeController.text,
                        avaregeDegreeController.text);
                    setState(() => loading = false);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewExamResult(String studentName, year, degree, subjectName,
      semister, semisterD, finalD, avarege) async {
    //This means that the user is performing an update
    if (widget.examResult != null) {
      if (subjectName == null) {
        subjectName = widget.examResult?.subjectName;
      }
      if (year == null) {
        year = widget.examResult?.year;
      }

      var subject = FirebaseFirestore.instance
          .collection(isTestMood ? 'examResultTest' : 'examResult')
          .doc(widget.examResult!.id);
      await subject.update({
        'id': widget.examResult!.id,
        'studentName': studentName,
        'year': year,
        'degree': degree,
        'subjectName': subjectName,
        'semister': semister,
        'finalDegree': finalD,
        'semersterDegree': semisterD,
        'avarege': avarege,
      });
      Navigator.pop(context);
      return;
    }

    final orders = FirebaseFirestore.instance
        .collection(isTestMood ? 'examResultTest' : 'examResult')
        .doc();
    await orders.set({
      'id': orders.id,
      'studentName': studentName,
      'year': year,
      'degree': degree,
      'subjectName': subjectName,
      'semister': semister,
      'finalDegree': finalD,
      'semersterDegree': semisterD,
      'avarege': avarege,
    });
    Navigator.pop(context);
  }
}
