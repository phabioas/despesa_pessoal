import 'package:despesa_pessoal/models/transaction.dart';

class TransactionProvider {
  final _transaction = [
    Transaction(
      id: '1',
      title: 'Tênis do mês passado',
      value: 49.99,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: '2',
      title: 'Tênis',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: '3',
      title: 'Meia',
      value: 6.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: '4',
      title: 'Calça',
      value: 49.99,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: '5',
      title: 'Calça',
      value: 49.99,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: '6',
      title: 'Calça',
      value: 49.99,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: '7',
      title: 'Calça',
      value: 49.99,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: '8',
      title: 'Calça',
      value: 49.99,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
  ];

  List<Transaction> getAll() {
    return _transaction;
  }
}
