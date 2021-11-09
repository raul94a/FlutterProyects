import 'package:calculadora/colors/text_color.dart';
import 'package:flutter/material.dart';

class CalculatorRow extends StatelessWidget {
  List<String> rowConfig;
  bool lightColor;
  Function(String) concatenateNumber;
  Function(String) setCalculationMode;
  VoidCallback calculation;
  VoidCallback reset;
  VoidCallback eraseDigit;
  VoidCallback changeSign;
  CalculatorRow(
      this.rowConfig,
      this.lightColor,
      this.concatenateNumber,
      this.setCalculationMode,
      this.calculation,
      this.reset,
      this.eraseDigit,
      this.changeSign);

  @override
  Widget build(BuildContext context) {
    //funcion de calculo de la anchura
    double setContainerWidth(String e) {
      double width = 0;
      switch (e) {
        case "=":
          width = 185;
          break;
        case "BACK":
          width = 185;
          break;
        default:
          width = 90;
          break;
      }
      return width;
    }

    Color getColor(String e) {
      Color color = Colors.transparent;
      if (['+', '-', '*', '/', 'BACK', 'C', '='].contains(e)) {
        color = lightColor
            ? Color.fromRGBO(250, 182, 188, 0.85)
            : Color.fromRGBO(15, 15, 30, 0.95);
      } else {
        color = lightColor
            ? Color.fromRGBO(233, 175, 200, 1)
            : Color.fromRGBO(10, 10, 10, 0.75);
      }
      return color;
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: rowConfig.map((e) {
          return Container(
            height: 90,
            decoration: BoxDecoration(
                border: Border.all(color: TextColor(lightColor).borderColor())),
            width: setContainerWidth(e),
            margin: const EdgeInsets.all(1),
            child: GestureDetector(
              child: RaisedButton(
                color: getColor(e),
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
                  else if (e == 'BACK')
                    {eraseDigit()}
                  else if (e == '+/-')
                    {changeSign()}
                },
                child: e == 'BACK'
                    ? Icon(Icons.backspace,
                        color: TextColor(lightColor).color())
                    : Text(
                        e,
                        style: TextStyle(
                            color: TextColor(lightColor).color(),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          );
        }).toList());
  }
}
