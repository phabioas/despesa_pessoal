import 'package:despesa_pessoal/components/adaptative_date_picker.dart';
import 'package:despesa_pessoal/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';
import 'adaptative_button.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSave;

  TransactionForm(this.onSave);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleControler = TextEditingController();
  final valorControler = TextEditingController();
  DateTime? _selectDate = DateTime.now();

  submitForm() {
    final title = titleControler.text;
    final double valor = double.tryParse(valorControler.text) ?? 0.0;

    if (title.isEmpty || valor <= 0 || _selectDate == null) {
      return;
    }

    widget.onSave(titleControler.text, valor, _selectDate!);
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                controller: titleControler,
                label: 'Descrição',
                hintLabel: 'Informe a despesa',
                onSubmit: (_) => submitForm(),
              ),
              AdaptativeTextField(
                controller: valorControler,
                label: 'Valor',
                hintLabel: 'Informe o valor da despesa',
                textInputType: TextInputType.numberWithOptions(decimal: true),
                onSubmit: (_) => submitForm(),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectDate,
                onDateChanged: (DateTime? newDate) {
                  setState(() {
                    _selectDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Incluir Transação',
                    onPressed: () => submitForm(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
