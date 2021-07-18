import 'dart:io';
import 'dart:math';
import 'package:despesa_pessoal/components/chart.dart';
import 'package:despesa_pessoal/components/transaction_form.dart';
import 'package:despesa_pessoal/providers/transactionProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpenseApp());

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Lista de Despesas
  final List<Transaction> _transactions = TransactionProvider().getAll();

  // Exibir ou não o Gráfico (Usado no modo paisagem)
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  // Adiciona uma despesa (USADO NO TRANSACTION_FORM)
  _addTransaction(String title, double value, DateTime selectedDate) {
    final newTransaction = Transaction(
        date: selectedDate,
        id: Random().nextDouble().toString(),
        title: title,
        value: value);

    setState(() {
      _transactions.add(newTransaction);
    });

    // FECHA O MODAL
    Navigator.of(context).pop();
  }

  // Exclui uma despesa
  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  // ABRE A TELA MODAL COM O TRANSACTION_FORM PARA INCLUIR UMA DESPESA
  _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    bool isLandscape = _mediaQuery.orientation == Orientation.landscape;

    Widget _getIconButton(IconData icon, Function()? fn) {
      return (Platform.isIOS)
          ? GestureDetector(
              onTap: fn,
              child: Icon(icon),
            )
          : IconButton(
              icon: Icon(icon),
              onPressed: fn,
            );
    }

    final _actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart ? Icons.list : Icons.show_chart,
          () => {
            setState(() {
              this._showChart = !_showChart;
            })
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionForm(context),
      ),
    ];

    // Cabeçalho para Dispositivo Android
    final PreferredSizeWidget appBarAndroid = AppBar(
      title: Center(
        child: Text(
          'Despesas Pessoais',
        ),
      ),
      actions: _actions,
    );

    // Cabeçalho para Dispositivo IOS
    final ObstructingPreferredSizeWidget appBarIos = CupertinoNavigationBar(
      middle: Text('Despesas Pessoais'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: _actions,
      ),
    );

    // Determinando o tamanho disponível para os elementos interagirem
    final avaliableHeight = _mediaQuery.size.height -
        ((Platform.isIOS)
            ? appBarIos.preferredSize.height
            : appBarAndroid.preferredSize.height) -
        _mediaQuery.padding.top;


    // SafeArea serve para que o fluter dimensione o espaço da aplicação dentro
    //da área disponível do dispositivo
    final _bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isLandscape || this._showChart)
              Container(
                height: avaliableHeight *
                    ((isLandscape)
                        ? 0.8
                        : 0.3), // se paisagem exibir 80%, senão 30%
                child: Chart(
                  recentTransaction: _recentTransaction,
                ),
              ),
            if (!isLandscape || !this._showChart)
              Container(
                height: avaliableHeight *
                    ((isLandscape)
                        ? 1
                        : 0.7), // se paisagem, exibir 100%, senão 70%
                child: TransactionList(
                  transactions: _transactions,
                  quandoDeletar: _deleteTransaction,
                ),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBarIos,
            child: _bodyPage,
          )
        : Scaffold(
            appBar: appBarAndroid,
            body: _bodyPage,
            floatingActionButton: (Platform.isAndroid)
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionForm(context))
                : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
