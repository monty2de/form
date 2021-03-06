import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/main.dart';
import 'package:form/utils/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class TeacherChangePass extends StatefulWidget {
  late String currentPass, email;
  TeacherChangePass(this.currentPass, this.email);
  @override
  _TeacherChangePass createState() => _TeacherChangePass();
}

class _TeacherChangePass extends State<TeacherChangePass> {
  String? yearName;

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController newPassController;
  late TextEditingController currentPassController;

  @override
  void initState() {
    super.initState();
    newPassController = TextEditingController();
    currentPassController = TextEditingController();
  }

  Widget textSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            'كلمة السر الحالية',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال السر الحالية';
              return null;
            },
            enabled: !loading,
            controller: currentPassController,
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
            ' كلمة السر الجديدة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال  كلمة السر الجديدة';
              return null;
            },
            enabled: !loading,
            controller: newPassController,
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
        title: Text(' تغيير كلمة السر '),
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
                    await changePass(
                        currentPassController.text, newPassController.text);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future changePass(String currentPass, newPass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (currentPass != this.widget.currentPass) {
      final snackBar = SnackBar(content: Text('كلمة السر الحالية غير صحيحة'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        loading = false;
      });

      return;
    } else {
      final scol = FirebaseFirestore.instance
          .collection(isTestMood ? 'teachersTest' : 'teachers');
      var id = sharedPreferences.getString('id');
      try {
        var subject = scol.doc(id);
        await subject.update({'pass': newPass});
      } catch (e) {
        String message = '';
        if (e.toString().contains('The password is invalid')) {
          message = 'كلمة المرور خطأ';
        } else {
          message = 'خطأ غير معروف';
        }
        final snackBar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      Navigator.pop(context);
    }
  }
}
