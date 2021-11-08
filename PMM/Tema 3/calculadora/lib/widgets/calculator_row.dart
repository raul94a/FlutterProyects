import 'package:flutter/material.dart';

class CalculatorRow extends StatelessWidget {
  List<String> rowConfig;
  Function(String) concatenateNumber;
  Function(String) setCalculationMode;
  VoidCallback calculation;
  VoidCallback reset;

  CalculatorRow(this.rowConfig, this.concatenateNumber, this.setCalculationMode,
      this.calculation, this.reset);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: rowConfig.map((e) {
          return Container(
            height: 90,
            width: 90,
            margin: const EdgeInsets.all(1),
            child: GestureDetector(
              child: RaisedButton(
                onPressed: () => {
                  if (['7', '8', '9', '4', '5', '6', '1', '2', '3', '0']
                      .contains(e))
                    {concatenateNumber(e)}
                  else if (['+', '-', '*', '/'].contains(e))
                    {setCalculationMode(e)}
                  else if (e == '=')
                    {calculation()}
                  else if (e == 'C')
                    {reset()}
                },
                child: Text(e),
              ),
            ),
          );
        }).toList());
  }
}
