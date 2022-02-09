import 'package:flutter/material.dart';

Widget checkIfListEmpty(
    {required Widget child, required List<dynamic> dataList}) {
  if (dataList.isNotEmpty)
    return child;
  else
    return Center(
      child: Text('لا يوجد بيانات لعرضها في القائمة'),
    );
}
