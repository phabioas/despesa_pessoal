import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleControler = TextEditingController();
  final valorControler = TextEditingController();

  final void Function(String, double) onSave;

  submitForm() {
    final title = titleControler.text;
    final double valor = double.tryParse(valorControler.text) ?? 0.0;

    if (title.isEmpty || valor <= 0) {
      return;
    }

    onSave(titleControler.text, valor);
  }

  TransactionForm(this.onSave);

  @override
  Widget build(BuildContext context) {
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
                onSubmitted: (_) => submitForm()),
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
