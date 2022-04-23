import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form/data/arrays.dart';
import 'package:form/main.dart';
import 'package:form/models/curriculum.dart';
import 'package:form/utils/app_button.dart';

class CurriculumAdd extends StatefulWidget {
  final int role;
  final int type;

  /// Should be passed when updating the curriculum
  final Curriculum? curriculum;

  CurriculumAdd(this.role, this.type, {this.curriculum});

  @override
  CurriculumAddState createState() => CurriculumAddState();
}

class CurriculumAddState extends State<CurriculumAdd> {
  String? yearName;
  String? semisterName;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController nameController;
  late TextEditingController yearController;
  late TextEditingController unitsController;

  @override
  void initState() {
    super.initState();
    yearName = widget.curriculum?.year;
    semisterName = widget.curriculum?.semister;

    nameController = TextEditingController(text: widget.curriculum?.name);
    yearController = TextEditingController(text: widget.curriculum?.year);
    unitsController =
        TextEditingController(text: widget.curriculum?.units.toString());
  }

  Widget textSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            'الاسم',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال الاسم';
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
            'الوحدات',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال الوحدات';
              return null;
            },
            enabled: !loading,
            controller: unitsController,
            cursorColor: Colors.black,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
        title: Text(widget.curriculum != null ? 'تعديل مادة' : 'اضافة مادة'),
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
                    await addNewCurriculum(nameController.text, yearName,
                        semisterName, unitsController.text);
                    setState(() => loading = true);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewCurriculum(String name, year, semisterName, units) async {
    //This means that the user is performing an update
    if (widget.curriculum != null) {
      var subject = FirebaseFirestore.instance
          .collection(isTestMood ? 'curriculumTest' : 'curriculum')
          .doc(this.widget.curriculum!.id);
      await subject.update({
        'id': this.widget.curriculum!.id,
        'name': name,
        'year': year,
        'semister': semisterName,
        "units": units,
      });
      Navigator.pop(context);
      return;
    }

    final orders = FirebaseFirestore.instance
        .collection(isTestMood ? 'curriculumTest' : 'curriculum')
        .doc();
    await orders.set({
      'id': orders.id,
      'name': name,
      'year': year,
      'type': widget.type,
      'semister': semisterName,
      "units": units,
    });
    Navigator.pop(context);
  }
}
