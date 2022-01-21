import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
}

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double? width;
  final ButtonType type;
  final Color? color;
  final bool loading;
  const AppButton(
      {Key? key,
      this.onPressed,
      this.loading = false,
      required this.title,
      this.width,
      this.type = ButtonType.primary,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.5,
      height: 40,
      margin: EdgeInsets.all(8),
      child: type == ButtonType.primary
          ? ElevatedButton(
              child: loading ? CircularProgressIndicator() : Text(title),
              onPressed: loading ? null : onPressed,
              style: ElevatedButton.styleFrom(primary: color),
            )
          : OutlinedButton(
              onPressed: loading ? null : onPressed,
              child: loading ? CircularProgressIndicator() : Text(title)),
    );
  }
}
