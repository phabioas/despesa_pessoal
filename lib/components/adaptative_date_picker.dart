import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptative_button.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime?) onDateChanged;

  AdaptativeDatePicker({
    this.selectedDate,
    required this.onDateChanged,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((valueDate) {
      if (valueDate == null) {
        return;
      }

      onDateChanged(valueDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    (this.selectedDate != null)
                        ? 'Data Selecionada: ${DateFormat('dd/MM/yyyy').format((selectedDate as DateTime))}'
                        : 'Nenhuma data Selecionada',
                  ),
                ),
                AdaptativeButton(
                  label: 'Selecionar Data',
                  onPressed: () => _showDatePicker(context),
                ),
              ],
            ),
          );
  }
}
