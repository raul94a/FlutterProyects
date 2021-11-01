import 'package:flutter/material.dart';
import 'package:gastos_app_2_0/widgets/chart_bars.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  List<Transaction> lastWeekTransactions;
  Chart(this.lastWeekTransactions);

  List<Map<String, Object>> _groupLastWeekTransactions() {
    return List.generate(7, (index) {
      DateTime date = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0;

      for (int i = 0; i < lastWeekTransactions.length; i++) {
        DateTime transactionDate = lastWeekTransactions[i].date!;
        if (date.day == transactionDate.day &&
            date.month == transactionDate.month &&
            date.year == transactionDate.year) {
          totalAmount += lastWeekTransactions[i].amount!;
        }
      }
      return {"date": date, "totalAmount": totalAmount};
    });
  }

  List<Map<String, Object>> get _groupedLastWeekTransactions {
    return _groupLastWeekTransactions();
  }

  double get _totalAmount {
    return _groupedLastWeekTransactions.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['totalAmount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 10,
          shadowColor: Colors.indigo,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 0.5)),
            child: ChartBars(_groupedLastWeekTransactions, _totalAmount),
          ) /*Column(
            children: _groupLastWeekTransactions().reversed.map((e) {
          return Column(children: [
            Text('${e['date']} gasté ${e['totalAmount']}'),
          ]);
        }).toList()),*/
          ),
    );
  }
}
