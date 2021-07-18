import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  late final String label;
  late final String? hintLabel;
  late final TextEditingController controller;
  late final dynamic Function(String)? onSubmit;
  late final TextInputType? textInputType;

  AdaptativeTextField({
    required this.controller,
    required this.label,
    this.onSubmit,
    this.hintLabel,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              placeholder: this.label,
              onSubmitted: this.onSubmit,
              controller: this.controller,
              keyboardType: this.textInputType,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            decoration: InputDecoration(
              labelText: label,
              hintText: hintLabel,
            ),
            onSubmitted: this.onSubmit,
            controller: this.controller,
            keyboardType: this.textInputType,
          );
  }
}
