import 'package:calculadora/colors/text_color.dart';
import 'package:flutter/material.dart';

class HistoryCalculation extends StatelessWidget {
  bool lightColor;
  String history;
  double availableWidth;

  HistoryCalculation(this.lightColor, this.history, this.availableWidth);
  @override
  Widget build(BuildContext context) {
    IconData getIcon() {
      IconData icon = Icons.ac_unit;
      if (history.contains('+'))
        icon = Icons.add;
      else if (history.contains('-'))
        icon = Icons.remove;
      else if (history.contains('*'))
        icon = Icons.clear;
      else if (history.contains('/')) icon = Icons.safety_divider;

      return icon;
    }

    Color getBorderColor() {
      Color color = Colors.transparent;

      if (history.contains('+'))
        color =
            lightColor ? Color.fromRGBO(120, 120, 255, 1) : Colors.lightBlue;
      else if (history.contains('-'))
        color = lightColor ? Color.fromRGBO(233, 85, 105, 1) : Colors.red;
      else if (history.contains('*'))
        color = lightColor ? Colors.deepPurple : Colors.yellow;
      else if (history.contains('/'))
        color =
            lightColor ? Color.fromRGBO(170, 240, 160, 1) : Colors.greenAccent;

      return color;
    }

    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: getBorderColor(), width: 3),
            borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
        height: 60,
        width: availableWidth * 0.25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(getIcon(),
                color: lightColor ? Colors.black : Colors.white, size: 20),
            Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  history.replaceAll('*', 'x'),
                  style: TextStyle(
                      fontSize: 20, color: TextColor(lightColor).color()),
                ),
              ),
            ),
          ],
        ));
  }
}
