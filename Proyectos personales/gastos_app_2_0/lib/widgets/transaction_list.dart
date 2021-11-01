import 'package:flutter/material.dart';
import 'package:gastos_app_2_0/models/transaction.dart';
import 'package:intl/intl.dart' as intl;

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function(String) deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 6,
            shadowColor: Colors.indigo,
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 120,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      '${transactions[index].amount!.toStringAsFixed(2)}€',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.deepPurple, width: 3)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${transactions[index].title}',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      '${intl.DateFormat('dd/MM/yyyy').format(transactions[index].date!)}',
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                ),
                Expanded(
                  child: IconButton(
                    alignment: Alignment.bottomRight,
                    color: Color.fromRGBO(92, 14, 120, 1),
                    onPressed: () => deleteTransaction(transactions[index].id),
                    icon: Icon(Icons.delete),
                    iconSize: 38,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
