import 'package:calculadora/colors/text_color.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final availableHeight;
  final availableWidth;
  final lightColor;
  final button;
  Function(String)? concatenateNumber;
  Function(String)? setCalculationMode;

  Function? calculation;
  Function? reset;
  Function? eraseDigit;
  Function? changeSign;

  CalculatorButton(
      {required this.availableHeight,
      required this.availableWidth,
      required this.lightColor,
      required this.button,
      this.concatenateNumber,
      this.calculation,
      this.changeSign,
      this.eraseDigit,
      this.reset,
      this.setCalculationMode});
  @override
  Widget build(BuildContext context) {
    double setContainerWidth(String e) {
      double width = 0;
      switch (button) {
        case "=":
          width = availableWidth > 650
              ? availableHeight * 0.48
              : availableHeight * 0.26;
          break;
        case "BACK":
          width = availableWidth > 650
              ? availableHeight * 0.48
              : availableHeight * 0.26;
          break;
        default:
          width = availableWidth > 650
              ? availableHeight * 0.22
              : availableHeight * 0.125;
          break;
      }
      return width;
    }

    Color getColor(String e) {
      Color color = Colors.transparent;
      if (['+', '-', '*', '/', 'BACK', 'C', '='].contains(button)) {
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

    return Container(
      height: availableHeight * 0.125,
      decoration: BoxDecoration(
          border: Border.all(color: TextColor(lightColor).borderColor())),
      width: setContainerWidth(button),
      margin: const EdgeInsets.all(1),
      child: GestureDetector(
        child: RaisedButton(
          color: getColor(button),
          onPressed: () => {
            if (['7', '8', '9', '4', '5', '6', '1', '2', '3', '0'].contains(button))
              {concatenateNumber!(button)}
            else if (['+', '-', '*', '/'].contains(button))
              {setCalculationMode!(button)}
            else if (button == '=')
              {calculation!()}
            else if (button == 'C')
              {reset!()}
            else if (button == 'BACK')
              {eraseDigit!()}
            else if (button == '+/-')
              {changeSign!()}
          },
          child: button == 'BACK'
              ? Icon(Icons.backspace, color: TextColor(lightColor).color())
              : Text(
                  button,
                  style: TextStyle(
                      color: TextColor(lightColor).color(),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
