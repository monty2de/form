// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form/models/student.dart';
import 'package:form/utils/app_button.dart';
import 'package:intl/intl.dart';

class StudentAddUpdate extends StatefulWidget {
  final int role;

  /// Should be passed when updating the curriculum
  final Student? student;

  StudentAddUpdate(this.role, {this.student});

  @override
  StudentAddUpdateState createState() => StudentAddUpdateState();
}

class StudentAddUpdateState extends State<StudentAddUpdate> {
  String? yearName;
  String? sextype;
  DateTime? dateStudent;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController bLocationController;
  late TextEditingController locationController;
  late TextEditingController numberController;
  late TextEditingController studentNameController;
  late TextEditingController passController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    yearName = widget.student?.year;
    sextype = widget.student?.sex;
    dateStudent = widget.student?.BDate;
    studentNameController = TextEditingController(text: widget.student?.name);
    bLocationController =
        TextEditingController(text: widget.student?.BLocation);
    locationController = TextEditingController(text: widget.student?.location);
    numberController = TextEditingController(text: widget.student?.number);
    passController = TextEditingController();
    emailController = TextEditingController();
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
    var sex = ['ذكر', 'انثى'];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم الطالب',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال اسم الطالب';
              return null;
            },
            enabled: !loading,
            controller: studentNameController,
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
            'الجنس',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          DropdownButtonFormField<String>(
            value: sextype,
            items: sex.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            validator: (value) {
              var temp = value ?? 0;
              if (temp == 0) return 'يجب اختيار الجنس';
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
                sextype = value;
              });
            },
          ),
          SizedBox(height: 10),
          Text(
            ' مكان الولادة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال  مكان الولادة';
              return null;
            },
            enabled: !loading,
            controller: bLocationController,
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
          SizedBox(height: 10),
          Text(
            'العنوان',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال العنوان';
              return null;
            },
            enabled: !loading,
            controller: locationController,
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
            'رقم الهاتف',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال رقم الهاتف';
              return null;
            },
            enabled: !loading,
            controller: numberController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
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
          widget.student == null
              ? Text(
                  'الايميل',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              : Container(),
          widget.student == null
              ? TextFormField(
                  enabled: !loading,
                  controller: emailController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    // icon: Icon(Icons.email, color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                )
              : Container(),
          SizedBox(height: 10),
          widget.student == null
              ? Text(
                  'كلمة المرور',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              : Container(),
          widget.student == null
              ? TextFormField(
                  enabled: !loading,
                  controller: passController,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    // icon: Icon(Icons.email, color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                )
              : Container(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: OutlinedButton(
              child: Text(dateStudent != null
                  ? DateFormat.yMMMMEEEEd('ar').format(dateStudent!)
                  : 'تاريخ الولادة '),
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
        title: Text(widget.student != null ? 'تعديل طالب' : 'اضافة طالب'),
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
                    await addNewStudent(
                        studentNameController.text,
                        sextype,
                        bLocationController.text,
                        dateStudent,
                        locationController.text,
                        numberController.text,
                        yearName,
                        emailController.text,
                        passController.text);
                    setState(() => loading = true);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewStudent(String studentName, sex, BLocation, BDate, location,
      number, year, email, pass) async {
    //This means that the user is performing an update
    if (widget.student != null) {
      if (BDate == null) {
        BDate = this.widget.student!.BDate;
      }
      var subject = FirebaseFirestore.instance
          .collection('students')
          .doc(this.widget.student!.id);
      await subject.update({
        'id': this.widget.student!.id,
        'name': studentName,
        'sex': sex,
        'BLocation': BLocation,
        'BDate': BDate,
        'location': location,
        'year': year,
        'number': number,
      });
      Navigator.pop(context);
      return;
    }

    UserCredential _authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: pass);

    FirebaseFirestore.instance
        .collection('students')
        .doc(
          _authResult.user!.uid,
        )
        .set({
      'id': _authResult.user!.uid,
      'name': studentName,
      'email': email,
      'sex': sex,
      'BLocation': BLocation,
      'BDate': BDate,
      'location': location,
      'year': year,
      'number': number,
      'pass': pass,
      'role': 3
    });

    Navigator.pop(context);
  }
}
