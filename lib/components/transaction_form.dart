import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSave;

  TransactionForm(this.onSave);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleControler = TextEditingController();
  final valorControler = TextEditingController();
  DateTime? _selectDate;

  submitForm() {
    final title = titleControler.text;
    final double valor = double.tryParse(valorControler.text) ?? 0.0;

    if (title.isEmpty || valor <= 0 || _selectDate == null) {
      return;
    }

    widget.onSave(titleControler.text, valor, _selectDate!);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((valueDate) {
      setState(() {
        _selectDate = valueDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      shadowColor: null,
      elevation: 0,
    );

    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Descrição'),
              onSubmitted: (_) => submitForm(),
              controller: titleControler,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor'),
              controller: valorControler,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      (this._selectDate != null)
                          ? 'Data Selecionada: ${DateFormat('dd/MM/yyyy').format((_selectDate as DateTime))}'
                          : 'Nenhuma data Selecionada',
                    ),
                  ),
                  ElevatedButton(
                    style: styleButton,
                    child: Text('Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => submitForm(),
                  child: Text('Incluir Transação'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple, onSurface: Colors.purple[50]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
