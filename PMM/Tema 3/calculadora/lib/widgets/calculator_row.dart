import 'package:calculadora/colors/text_color.dart';
import 'package:calculadora/config/app_config.dart';
import 'package:calculadora/widgets/calculator_button.dart';
import 'package:flutter/material.dart';

class CalculatorRow extends StatelessWidget {
  final availableHeight;
  final availableWidth;
  List<String> rowConfig;
  bool lightColor;
  Function(String) concatenateNumber;
  Function(String) setCalculationMode;
  VoidCallback calculation;
  VoidCallback reset;
  VoidCallback eraseDigit;
  VoidCallback changeSign;
  CalculatorRow(
      this.availableHeight,
      this.availableWidth,
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
    Widget mobileRow(String button) {
      return CalculatorButton(
          //parametros obligatorios
          availableHeight: availableHeight,
          availableWidth: availableWidth,
          lightColor: lightColor,
          button: button,
          //parametros opcionales
          concatenateNumber:
              numbers.contains(button) ? concatenateNumber : null,
          calculation: button == '=' ? calculation : null,
          changeSign: button == '+/-' ? changeSign : null,
          eraseDigit: button == 'BACK' ? eraseDigit : null,
          reset: button == 'C' ? reset : null,
          setCalculationMode:
              modos.contains(button) ? setCalculationMode : null);
    }

    Widget webRow(String button) {
      return Flexible(fit: FlexFit.tight, child: mobileRow(button));
    }

    return Container(
      width: availableWidth > 650 ? availableWidth / 2 : availableWidth,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: rowConfig.map((button) {
            return availableWidth > 650 ? webRow(button) : mobileRow(button);
          }).toList()),
    );
  }
}
