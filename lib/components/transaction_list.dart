import 'package:despesa_pessoal/components/car_transaction.dart';
import 'package:despesa_pessoal/components/transaction_list_blank.dart';
import 'package:despesa_pessoal/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  late final Function(String id) quandoDeletar;

  TransactionList({
    required this.transactions,
    required this.quandoDeletar,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? TransactionListBlank()
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final t = transactions[index];
              return CarTransaction(
                t: t,
                quandoDeletar: quandoDeletar,
              );
            },
          );
  }
}
