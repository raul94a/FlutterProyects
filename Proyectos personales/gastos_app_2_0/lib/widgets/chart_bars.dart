import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' as intl;

class ChartBars extends StatelessWidget {
  List<Map<String, Object>> groupedLastWeekTransactions;
  double totalAmount;
  ChartBars(this.groupedLastWeekTransactions, this.totalAmount);
  double _getPercentage(double moneyOfTheDay) {
    return (moneyOfTheDay / totalAmount);
  }

  Map<String, String> _spanishTranslator() => {
        "Mo": "L",
        "Tu": "M",
        "We": "X",
        "Th": "J",
        "Fr": "V",
        "Sa": "S",
        "Su": "D"
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Row(
          children: groupedLastWeekTransactions.reversed.map((e) {
        return Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  '${(e['totalAmount'] as double).toStringAsFixed(0)}€',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: 15,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    FractionallySizedBox(
                      heightFactor: _getPercentage(e['totalAmount'] as double),
                      child: Container(
                        width: 15,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(72, 0, 72, 1),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${_spanishTranslator()[(intl.DateFormat.E().format(e['date'] as DateTime).substring(0, 2))]}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        );
      }).toList()),
    );
  }
}
