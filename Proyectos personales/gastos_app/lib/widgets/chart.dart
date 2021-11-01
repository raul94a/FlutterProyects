

import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';
import 'package:gastos_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart' as intl;

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date!.day == weekDay.day &&
            recentTransactions[i].date!.month == weekDay.month &&
            recentTransactions[i].date!.year == weekDay.year) {
          totalSum += recentTransactions[i].amount!;
        }
      }
      return {
        'day': intl.DateFormat.E().format(weekDay).substring(0, 1),
        'amount': double.parse(totalSum.toStringAsFixed(2))
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.reversed.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: e['day'].toString(),
                    spendingAmount: e['amount'] as double,
                    spendingPctOfTotal: totalSpending == 0
                        ? 0.0
                        : (e['amount'] as double) / totalSpending),
              );
            }).toList()),
      ),
    );
  }
}
