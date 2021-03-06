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
  late TextEditingController resolutionDegreeController;
  late TextEditingController finalDegreeController;
  // late TextEditingController avaregeDegreeController;

  @override
  void initState() {
    super.initState();
    yearName = widget.examResult?.year;
    semisterName = widget.examResult?.semister;
    subjectName = widget.examResult?.subjectName;
    stName = widget.examResult?.studentName;
    semesterDegreeController =
        TextEditingController(text: widget.examResult?.semersterDegree ?? "0");
    resolutionDegreeController =
        TextEditingController(text: widget.examResult?.resolutionDegree ?? "0");
    finalDegreeController =
        TextEditingController(text: widget.examResult?.finalDegree ?? "0");
    // avaregeDegreeController =
    //     TextEditingController(text: widget.examResult?.finalDegree);
    studentNameController =
        TextEditingController(text: widget.examResult?.studentName);
    degreeController =
        TextEditingController(text: widget.examResult?.degree ?? "0");
  }

  String getFinalDegree() {
    final degree = int.parse(semesterDegreeController.text) +
        int.parse(degreeController.text) +
        int.parse(resolutionDegreeController.text);
    return degree.toString();
  }

  Widget textSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            '??????????????',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          DropdownButtonFormField<String>(
            value: yearName,
            items: yearArry.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            validator: (value) {
              var temp = value ?? 0;
              if (temp == 0) return '?????? ???????????? ??????????????';
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
                stName = null;
                yearName = value;
              });
            },
          ),
          if (yearName != null)
            Text(
              '?????? ????????????',
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
            '?????????? ??????????????',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          DropdownButtonFormField<String>(
            value: semisterName,
            items: semisterArry.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            validator: (value) {
              var temp = value ?? 0;
              if (temp == 0) return '?????? ???????????? ?????????? ??????????????';
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
                semisterName = value;
              });
            },
          ),
          if (semisterName != null && yearName != null)
            Text(
              '  ?????? ???????????? ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          if ((semisterName != null) && yearName != null)
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
                    if (temp == 0) return '?????? ???????????? ?????? ????????????';
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
            '??????????',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return '?????? ?????????? ????????????';
              return null;
            },
            enabled: !loading,
            controller: semesterDegreeController,
            onChanged: (v) => finalDegreeController.text = getFinalDegree(),
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
            '???????? ????????????',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return '?????? ??????????  ????????????';
              return null;
            },
            enabled: !loading,
            onChanged: (v) => finalDegreeController.text = getFinalDegree(),
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
            '???????? ????????????',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            enabled: !loading,
            controller: resolutionDegreeController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            onChanged: (v) => finalDegreeController.text = getFinalDegree(),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              // icon: Icon(Icons.email, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          Text(
            '???????????? ????????????????',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return '?????? ?????????? ????????????';
              return null;
            },
            enabled: false,
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
          // if (yearName == '??????????????')
          //   Text(
          //     '????????????',
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //   ),
          // if (yearName == '??????????????')
          //   TextFormField(
          //     validator: (value) {
          //       if (value!.isEmpty) return '?????? ?????????? ????????????';
          //       return null;
          //     },
          //     enabled: !loading,
          //     controller: avaregeDegreeController,
          //     cursorColor: Colors.black,
          //     style: TextStyle(color: Colors.black),
          //     decoration: InputDecoration(
          //       border:
          //           OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          //       // icon: Icon(Icons.email, color: Colors.black),
          //       hintStyle: TextStyle(color: Colors.black),
          //     ),
          //   ),
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
        title: Text(widget.examResult != null ? '?????????? ????????' : '?????????? ????????'),
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
                      resolutionDegreeController.text,
                    );
                    setState(() => loading = false);
                  }
                },
                title: '??????'),
          ],
        ),
      ),
    );
  }

  Future addNewExamResult(String studentName, year, degree, subjectName,
      semister, semisterD, finalD, resolutionD) async {
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
        "resolutionDegree": resolutionD,
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
      "resolutionDegree": resolutionD,
    });
    Navigator.pop(context);
  }
}
