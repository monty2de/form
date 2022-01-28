import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/models/news.dart';
import 'package:form/utils/app_button.dart';

class NewsAddUpdate extends StatefulWidget {
  final int role;

  /// Should be passed when updating the curriculum
  final News? news;

  NewsAddUpdate(this.role, {this.news});

  @override
  NewsAddUpdateState createState() => NewsAddUpdateState();
}

class NewsAddUpdateState extends State<NewsAddUpdate> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController bodyController;
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    bodyController = TextEditingController(text: widget.news?.body);
    titleController = TextEditingController(text: widget.news?.title);
  }

  Widget textSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
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
            controller: titleController,
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
            'الوصف',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال الوصف';
              return null;
            },
            enabled: !loading,
            controller: bodyController,
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
        title: Text(widget.news == null ? 'اضافة خبر' : 'تعديل خبر'),
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
                    await addNewnews(titleController.text, bodyController.text);
                    setState(() => loading = true);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewnews(String title, body) async {
    //This means that the user is performing an update
    if (widget.news != null) {
      var subject = FirebaseFirestore.instance
          .collection('news')
          .doc(this.widget.news?.id);
      await subject
          .update({'id': this.widget.news?.id, 'title': title, 'body': body});
      Navigator.pop(context);
      return;
    }
    String id = generateRandomString(32);
    final check =
        await FirebaseFirestore.instance.collection('news').doc(id).get();
    if (check.exists) id = generateRandomString(32);

    final orders = FirebaseFirestore.instance.collection('news').doc(id);
    await orders.set({'id': id, 'title': title, 'body': body});
    Navigator.pop(context);
  }

  String generateRandomString(int len) {
    var r = Random.secure();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
