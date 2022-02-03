// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/utils/app_button.dart';

class WornAdd extends StatefulWidget {



  @override
  WornAddState createState() => WornAddState();
}

class WornAddState extends State<WornAdd> {
  String? stName;


  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  late TextEditingController bodyController;
@override
  void initState() {
    super.initState();
    bodyController = TextEditingController();
  }

  Widget textSection() {
 
  
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            'اسم الطالب',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('students').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('error');
              }
              List<String> shubjects = [];
              for (var i = 0; i < snapshot.data!.docs.length; i++) {
                shubjects.add(snapshot.data!.docs[i]['name']);
              }
              return DropdownButtonFormField(
                
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
            ' الوصف',
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
        title: Text( 'اضافة نبليغ'),
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
                    await addNewWorn(
                       stName! , bodyController.text);
                    setState(() => loading = true);
                  }
                },
                title: 'حفظ'),
          ],
        ),
      ),
    );
  }

  Future addNewWorn(String studentName, body) async {
  
  String id = generateRandomString(32);
    final check =
        await FirebaseFirestore.instance.collection('worns').doc(id).get();
    if (check.exists) id = generateRandomString(32);

    final orders = FirebaseFirestore.instance.collection('worns').doc(id);
    await orders.set({'id': id, 'stname': stName, 'body': body });


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
