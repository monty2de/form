import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/data/arrays.dart';
import 'package:form/main.dart';
import 'package:form/utils/app_button.dart';
import 'package:intl/intl.dart';

class AbscenceAdd extends StatefulWidget {
  @override
  AbscenceAddState createState() => AbscenceAddState();
}

class AbscenceAddState extends State<AbscenceAdd> {
  String? stId;
  String? yearName;
  String? stName;
  String? subject;
  String? semisterName;
  DateTime? date;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

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
                stName = null;
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
                    stId = snapshot.data!.docs
                        .firstWhere((s) =>
                            value.toString() ==
                            (s.data() as Map<String, dynamic>)['name'])
                        .id;
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('loading..');
                }
                List<String> shubjects = [];
                for (var i = 0; i < snapshot.data!.docs.length; i++) {
                  shubjects.add(snapshot.data!.docs[i]['name']);
                }
                return DropdownButtonFormField(
                  value: subject,
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
                    subject = value.toString();
                  },
                );
              },
            ),
          SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: OutlinedButton(
              child: Text(date != null
                  ? DateFormat.yMMMMEEEEd('ar').format(date!)
                  : 'التاريخ  '),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: date ?? DateTime.now(),
                        firstDate: DateTime(1960),
                        lastDate: DateTime(2222))
                    .then((sdate) {
                  setState(() {
                    date = sdate!;
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
        title: Text('اضافة غياب'),
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
                    await addNewAbs();
                    setState(() => loading = false);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewAbs() async {
    final orders = FirebaseFirestore.instance
        .collection(isTestMood ? 'abscencesTest' : 'abscences')
        .doc();
    await orders.set({
      'id': orders.id,
      'stName': stName,
      'stId': stId,
      'year': yearName,
      "semisterName": semisterName,
      'date': date?.toIso8601String(),
      "subject": subject,
    });

    Navigator.pop(context);
  }
}
