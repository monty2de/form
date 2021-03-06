import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/main.dart';
import 'package:form/models/teacher.dart';
import 'package:form/utils/app_button.dart';
import 'package:intl/intl.dart';

class TeacherAddUpdate extends StatefulWidget {
  final int role;

  /// Should be passed when updating the curriculum
  final Teacher? teacher;

  TeacherAddUpdate(this.role, {this.teacher});

  @override
  TeacherAddUpdateState createState() => TeacherAddUpdateState();
}

class TeacherAddUpdateState extends State<TeacherAddUpdate> {
  String? position;
  late DateTime? dateStudent;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController emailController;
  late TextEditingController locationController;
  late TextEditingController passController;
  late TextEditingController numberController;
  late TextEditingController teacherNameController;

  @override
  void initState() {
    dateStudent = widget.teacher?.BDate;
    super.initState();
    position = widget.teacher?.position;
    teacherNameController = TextEditingController(text: widget.teacher?.name);
    numberController = TextEditingController(text: widget.teacher?.number);
    passController = TextEditingController();
    emailController = TextEditingController(text: widget.teacher?.email);
    locationController = TextEditingController(text: widget.teacher?.location);
  }

  Widget textSection() {
    var positionarray = ['منتسب', 'خدمات', 'تدريسي', 'مهندس'];
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
            controller: teacherNameController,
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
            'العنوان الوظيفي',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          DropdownButtonFormField<String>(
            value: position,
            items: positionarray.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            validator: (value) {
              var temp = value ?? 0;
              if (temp == 0) return 'يجب اختيار العنوان الوظيفي';
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
                position = value;
              });
            },
          ),
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
            'الايميل',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            enabled: !loading,
            controller: emailController,
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
          widget.teacher == null
              ? Text(
                  'كلمة السر',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              : Container(),
          widget.teacher == null
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
                  : 'تاريخ الولادة  '),
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
        title: Text(widget.teacher != null ? 'تعديل موظف' : 'اضافة موظف'),
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
                    await addNewTeacher(
                        teacherNameController.text,
                        dateStudent,
                        locationController.text,
                        numberController.text,
                        emailController.text,
                        passController.text,
                        position ?? '');
                  }
                  setState(() => loading = false);
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future addNewTeacher(String teacherName, DateTime? BDate, String location,
      String number, String email, String pass, String position) async {
    //This means that the user is performing an update
    if (widget.teacher != null) {
      var subject = FirebaseFirestore.instance
          .collection(isTestMood ? 'teachersTest' : 'teachers')
          .doc(widget.teacher!.id);
      await subject.update({
        'id': this.widget.teacher!.id,
        'name': teacherName,
        'BDate': BDate?.toIso8601String(),
        'location': location,
        'number': number,
        'role': 2,
        'position': position,
        "email": email,
      });
      Navigator.pop(context);
      return;
    }
    try {
      final tcollection = FirebaseFirestore.instance
          .collection(isTestMood ? 'teachersTest' : 'teachers');
      final userExist = await checkIfUserExsists(tcollection, 'email', email);
      if (!userExist) {
        final doc = tcollection.doc();
        doc.set({
          'id': doc.id,
          'name': teacherName,
          'email': email,
          'BDate': BDate?.toIso8601String(),
          'location': location,
          'number': number,
          'pass': pass,
          'role': 2,
          'position': position
        });
      } else {
        throw 'email-already-in-use';
      }
    } catch (e) {
      setState(() {
        loading = false;
      });

      var message = e.toString();
      if (message.contains('email-already-in-use')) {
        message = 'الايميل مستخدم ';
      }
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Navigator.pop(context);
  }
}

Future<bool> checkIfUserExsists(
    CollectionReference<Map<String, dynamic>> collection,
    String field,
    String isEqual) async {
  return (await collection.where(field, isEqualTo: isEqual).get())
      .docs
      .isNotEmpty;
}
