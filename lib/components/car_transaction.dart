import 'package:despesa_pessoal/components/buttonCancel.dart';
import 'package:despesa_pessoal/components/buttonCheck.dart';
import 'package:despesa_pessoal/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarTransaction extends StatelessWidget {
  final Transaction t;
  final Function(String id) quandoDeletar;

  const CarTransaction({
    Key? key,
    required this.t,
    required this.quandoDeletar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void Function()? showDialogDelete(String id) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Excluir Transação',
            style: TextStyle(color: Colors.red),
          ),
          content: Text('Confirma exclusão da despesa?'),
          actions: [
            ButtonCancel(
              text: 'Não',
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ButtonCheck(
              text: "Sim",
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      ).then((value) {
        if (value) {
          quandoDeletar(id);
        }
      });
    }

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(child: Text('${t.value.toStringAsFixed(2)}')),
            ),
          ),
          title: Text(
            t.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat('d MMM y').format(t.date),
          ),
          trailing: MediaQuery.of(context).size.width > 400
              ? ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).errorColor),
                  ),
                  label: Text('Excluir'),
                  onPressed: () => showDialogDelete(t.id))
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => showDialogDelete(t.id),
                )),
    );
  }
}
