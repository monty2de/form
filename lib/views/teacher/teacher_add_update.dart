
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/models/teacher.dart';
import 'package:form/utils/app_button.dart';

class TeacherAddUpdate extends StatefulWidget {
  final int role;

  /// Should be passed when updating the curriculum
  final Teacher? teacher;

  TeacherAddUpdate(this.role,  {this.teacher});

  @override
  TeacherAddUpdateState createState() => TeacherAddUpdateState();
}

class TeacherAddUpdateState extends State<TeacherAddUpdate> {
  String? position;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController bDateController;
  late TextEditingController emailController;
  late TextEditingController locationController;
  late TextEditingController passController;
  late TextEditingController numberController;
  late TextEditingController teacherNameController;

  @override
  void initState() {
    super.initState();
    position = widget.teacher?.position;
    teacherNameController = TextEditingController(text: widget.teacher?.name);
    numberController = TextEditingController(text: widget.teacher?.number);
    passController = TextEditingController();
    emailController = TextEditingController();
    locationController = TextEditingController(text: widget.teacher?.location);
    bDateController = TextEditingController(text: widget.teacher?.BDate);

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
              icon: Icon(Icons.email, color: Colors.black),
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
              if (value!.isEmpty) return 'يجب اختيار العنوان الوظيفي';
              return null;
            },
            enableFeedback: !loading,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              icon: Icon(Icons.stacked_bar_chart, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (value) {
              setState(() {
                position= value;
              });
            },
          ),
          SizedBox(height: 10),
          Text(
            'تاريخ الولادة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال تاريخ الولادة';
              return null;
            },
            enabled: !loading,
            controller: bDateController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              icon: Icon(Icons.email, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
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
              icon: Icon(Icons.email, color: Colors.black),
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
              icon: Icon(Icons.email, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
          widget.teacher == null? Text(
            'الايميل',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ) : Container(),
          widget.teacher == null?TextFormField(
            
            enabled: !loading,
            controller: emailController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              icon: Icon(Icons.email, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ): Container(),

          SizedBox(height: 10),
          widget.teacher == null? Text(
            'كلمة السر',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ) : Container(),
          widget.teacher == null?TextFormField(
            
            enabled: !loading,
            controller: passController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              icon: Icon(Icons.email, color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
            ),
          ): Container(),
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
        title: Text(widget.teacher!= null ? 'اضافة موظف' : 'تعديل موظف'),
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
                    await addNewTeacher(teacherNameController.text, bDateController.text , locationController.text , numberController.text , emailController.text , passController.text , position  );
                    setState(() => loading = true);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewTeacher(String teacherName, BDate, location, number, email, pass,position) async {
    
    //This means that the user is performing an update
    if (widget.teacher != null) {
      var subject = FirebaseFirestore.instance
          .collection('teachers')
          .doc(this.widget.teacher!.id);
      await subject.update(
          {'id': this.widget.teacher!.id, 'name' : teacherName,
        'BDate' : BDate,
        'location' : location,
        'number' : number,
        'role' :2,
        'position' : position});
      Navigator.pop(context);
      return;
    }
    UserCredential _authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: pass);

        FirebaseFirestore.instance
        .collection('teachers')
        .doc(
          _authResult.user!.uid,
        )
        .set({
      'id': _authResult.user!.uid,
      'name': teacherName,
      'email': email,
      'BDate': BDate,
      'location': location,
      'number': number,
      'pass': pass,
      'role': 2,
      'position': position
    });

    Navigator.pop(context);
  }

 
}
