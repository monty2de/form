import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form/data/arrays.dart';
import 'package:form/main.dart';
import 'package:form/models/student.dart';
import 'package:form/utils/app_button.dart';
import 'package:form/views/teacher/teacher_add_update.dart';
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
  late String yearName;
  String? status;

  late String sextype;
  String? shift;

  DateTime? dateStudent;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController bLocationController;
  late TextEditingController locationController;
  late TextEditingController numberController;
  late TextEditingController studentNameController;
  late TextEditingController passController;
  late TextEditingController emailController;
  late TextEditingController partController;

  @override
  void initState() {
    super.initState();
    yearName = widget.student?.year ?? 'الأولى';
    sextype = widget.student?.sex ?? 'ذكر';
    shift = widget.student?.shift;
    dateStudent = widget.student?.bDate;
    status = widget.student?.status;
    studentNameController = TextEditingController(text: widget.student?.name);
    bLocationController =
        TextEditingController(text: widget.student?.bLocation);
    locationController = TextEditingController(text: widget.student?.location);
    numberController = TextEditingController(text: widget.student?.number);
    partController = TextEditingController(text: widget.student?.part);

    passController = TextEditingController(text: widget.student?.pass);
    emailController = TextEditingController(text: widget.student?.email);
  }

  Widget textSection() {
    print(widget.role);
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
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'المرحلة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          IgnorePointer(
            ignoring: widget.role > 2,
            child: DropdownButtonFormField<String>(
              value: yearName,
              items: yearArry.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              validator: (value) {
                var temp = value ?? 0;
                if (temp == 0) return 'يجب اختيار المرحلة';
                return null;
              },
              enableFeedback: !loading,
              decoration: InputDecoration(
                enabled: !loading && widget.role <= 2,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (value) {
                setState(() {
                  yearName = value!;
                });
              },
            ),
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
              hintStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) {
              setState(() {
                sextype = value!;
              });
            },
          ),
          SizedBox(height: 10),
          Text(
            'الدوام',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          IgnorePointer(
            ignoring: widget.role > 2,
            child: DropdownButtonFormField<String>(
              value: shift,
              items: shifts.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              validator: (value) {
                var temp = value ?? 0;
                if (temp == 0) return 'يجب اختيار الدوام';
                return null;
              },
              enableFeedback: !loading,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (value) {
                setState(() {
                  shift = value;
                });
              },
            ),
          ),
          SizedBox(height: 10),
          Text(
            'الحالة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          IgnorePointer(
            ignoring: widget.role > 2,
            child: DropdownButtonFormField<String>(
              value: status,
              items: statusArry.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              validator: (value) {
                var temp = value ?? 0;
                if (temp == 0) return 'يجب اختيار الحالة';
                return null;
              },
              enableFeedback: !loading,
              decoration: InputDecoration(
                enabled: !loading && widget.role == 2,

                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                // icon: Icon(Icons.stacked_bar_chart, color: Colors.black),
                hintStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (value) {
                setState(() {
                  status = value;
                });
              },
            ),
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
          Text(
            'الشعبة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال الشعبة';
              return null;
            },
            enabled: !loading && widget.role <= 2,
            controller: partController,
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
          widget.student == null
              ? Text(
                  'الايميل',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              : SizedBox(),
          IgnorePointer(
            ignoring: widget.role > 2,
            child: TextFormField(
              enabled: !loading,
              controller: emailController,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabled: widget.role <= 2,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                // icon: Icon(Icons.email, color: Colors.black),
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
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
                      dateStudent?.toIso8601String(),
                      locationController.text,
                      numberController.text,
                      yearName,
                      emailController.text,
                      passController.text,
                      status,
                      partController.text,
                      shift,
                    );
                  }
                  setState(() => loading = false);
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewStudent(
      String studentName,
      String sex,
      String? bLocation,
      String? bDate,
      String? location,
      String? number,
      String year,
      String email,
      String pass,
      String? status,
      String? part,
      String? shift) async {
    //This means that the user is performing an update
    if (widget.student != null) {
      var subject = FirebaseFirestore.instance
          .collection(isTestMood ? 'studentsTest' : 'students')
          .doc(this.widget.student!.id);
      await subject.update({
        'id': this.widget.student!.id,
        'name': studentName,
        'sex': sex,
        'BLocation': bLocation,
        'BDate': bDate,
        'location': location,
        'year': year,
        'number': number,
        'status': status,
        'part': part,
        "email": email,
        "shift": shift
      });
      Navigator.pop(context);
      return;
    }
    try {
      final scollection = FirebaseFirestore.instance
          .collection(isTestMood ? 'studentsTest' : 'students');
      final userExist = await checkIfUserExsists(scollection, 'email', email);

      if (userExist) {
        final doc = scollection.doc();
        doc.set({
          'id': doc.id,
          'name': studentName,
          'email': email,
          'sex': sex,
          'BLocation': bLocation,
          'BDate': bDate,
          'location': location,
          'year': year,
          'number': number,
          'pass': pass,
          'role': 3,
          'status': status,
          'part': part,
          "shift": shift
        });
      } else {
        throw 'email-already-in-use';
      }
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });

      var message = e.toString();
      if (message.contains('email-already-in-use')) {
        message = 'الايميل مستخدم ';
      } else {
        message = 'حدث خطأ غير معروف';
      }
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Navigator.pop(context);
  }
}
