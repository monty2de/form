import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form/main.dart';
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
            stream: FirebaseFirestore.instance
                .collection(isTestMood ? 'studentsTest' : 'students')
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
            ' الوصف',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) return 'يجب ادخال الوصف';
              return null;
            },
            maxLines: 3,
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
        title: Text('اضافة تبليغ'),
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
                    await addNewWorn(stName!, bodyController.text);
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
    final orders = FirebaseFirestore.instance
        .collection(isTestMood ? 'wornsTest' : 'worns')
        .doc();
    await orders.set({'id': orders.id, 'stname': stName, 'body': body});

    Navigator.pop(context);
  }
}
