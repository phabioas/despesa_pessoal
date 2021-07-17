import 'package:flutter/material.dart';

class TransactionListBlank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.05, // 5%
          ),
          Container(
            height: constraints.maxHeight * 0.2, // 20%
            child: Text(
              'Nenhuma transação Cadastrada!',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05, // 5%
          ),
          Container(
            height: constraints.maxHeight * 0.7, // 70%
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    });
  }
}
