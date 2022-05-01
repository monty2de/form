import 'package:flutter/material.dart';
import 'package:form/utils/app_button.dart';

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onOkay;
  final String? title;
  const ConfirmDialog({Key? key, required this.onOkay, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "هل انت متاكد من اتمام العملية"),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        AppButton(
          title: 'موافق',
          onPressed: () {
            onOkay();
            Navigator.of(context).pop();
          },
          width: 100,
        ),
        AppButton(
          title: 'الغاء',
          color: Colors.grey,
          onPressed: Navigator.of(context).pop,
          width: 100,
        )
      ],
    );
  }
}
