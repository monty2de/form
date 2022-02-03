import 'package:flutter/material.dart';
import 'package:form/Controllers/StudentController.dart';
import 'package:form/models/worn.dart';

import '../../drawer.dart';

// ignore: must_be_immutable
class StudentWorns extends StatefulWidget {
late String name;
late int role;
StudentWorns(this.name , this.role);

  @override
  _StudentWorns createState() => _StudentWorns();
}

class _StudentWorns extends State<StudentWorns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(this.widget.role),
      appBar: AppBar(
        
        centerTitle: true,
        title: Text('التبليغات'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: StudentController().worn(this.widget.name),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    return _loading();
                  case ConnectionState.waiting:
                    return _loading();
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Container();
                    }
                    if (snapshot.hasData) {
                      return result(snapshot.data, context);
                    }
                    break;
                  case ConnectionState.none:
                    break;
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget result(List<Worn> result, BuildContext context) {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(label: Text(" الوصف"), numeric: false),

     
      ],
      rows: result
          .map(
            (subject) => DataRow(
              cells: [
                DataCell(Text(subject.body),),
    
                
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
