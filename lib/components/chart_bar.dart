import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  late final String label;
  late final double value;
  late final double percentage;

  ChartBar(
      {required this.label, required this.value, required this.percentage});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder é usado aqui para que se consiga trabalhar a responsividade.
    // Através da constraints pegamos o valor da altura do elemento e distribuir por porcentagem nos elementos filhos
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15, // 15%
            child: FittedBox(
              child: Text('${value.toStringAsFixed(2)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05, // 5%
          ),
          Container(
            height: constraints.maxHeight * 0.60, // 60%
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05, // 05%
          ),
          Container(
            height: constraints.maxHeight * 0.15, // 15%
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
