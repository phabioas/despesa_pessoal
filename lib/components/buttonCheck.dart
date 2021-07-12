import 'package:flutter/material.dart';

class ButtonCheck extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  ButtonCheck({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(text),
      icon: Icon(Icons.check),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
      ),
      onPressed: onPressed,
    );
  }
}
