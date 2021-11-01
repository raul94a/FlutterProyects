import 'dart:convert';

import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/chart.dart';
import '../widgets/no_data.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';
import '../models/transaction.dart';

class HomePage extends StatefulWidget {
  @override
  Storage storage;
  HomePage(this.storage);
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _transactions = [];
  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((String value) {
      setState(() {
        _transactions = loadTransactionsFromFile(value);
      });
    });
  }

  List<Transaction> loadTransactionsFromFile(String transactions) {
    List transactionList = jsonDecode(transactions)['transactions'] as List;
    List<Transaction> transactionsList = [];
    for (int i = 0; i < transactionList.length; i++) {
      Transaction? t = Transaction(
          transactionList[i]['id'],
          transactionList[i]['title'],
          transactionList[i]['amount'],
          DateTime.parse(transactionList[i]['date']));
      transactionsList.add(t);
    }
    return transactionsList;
  }

  Map toJson() {
    return {"transactions": _transactions.map((e) => e.toJson()).toList()};
  }

  List<Transaction> get _lastWeekTransactions {
    return _transactions
        .where((element) => element.date!
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  Transaction? _createNewTransaction(
      String title, String amount, DateTime? date) {
    return title.isEmpty || amount.isEmpty || date == null
        ? null
        : Transaction(DateTime.now().toString(), title,
            double.parse(amount.replaceAll(',', '.')), date);
  }

  dynamic _addNewTransaction(
      String title, String amount, DateTime? date) async {
    Transaction? transaction = _createNewTransaction(title, amount, date);
    if (transaction == null) return;

    setState(() {
      _transactions.add(transaction);
    });
    await widget.storage.writeFile(jsonEncode(toJson()));
  }

  void _deleteTransaction(String id) async {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
    widget.storage.writeFile(jsonEncode(toJson()));
  }

  void _startNewTransaction() async {
    await widget.storage.localDirectory();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    print(_transactions);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('Gastos Personales'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _startNewTransaction, icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: _transactions.length == 0
            ? NoData()
            : Column(
                children: [
                  Chart(_lastWeekTransactions),
                  TransactionList(_transactions, _deleteTransaction),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          //color: Colors.white,
        ),
        onPressed: _startNewTransaction,
      ),
    );
  }
}
