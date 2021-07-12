import 'package:flutter/material.dart';

class ButtonCancel extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  ButtonCancel({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(text),
      icon: Icon(Icons.cancel),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
      ),
      onPressed: onPressed,
    );
  }
}
