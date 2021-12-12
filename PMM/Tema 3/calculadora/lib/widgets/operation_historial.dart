import 'package:calculadora/colors/text_color.dart';
import 'package:flutter/material.dart';

import 'history_calculation.dart';

class OperationHistorial extends StatelessWidget {
  bool lightColor;
  List<String> historic;
  VoidCallback historicHandler;
  double availableWidth;
  String mode;
  
  OperationHistorial(this.lightColor, this.historic, this.historicHandler,
      this.availableWidth, this.mode);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Historial de operaciones',
          textAlign: TextAlign.center,
          style: TextStyle(color: TextColor(lightColor).color(), fontSize: 22),
        ),
        SizedBox(
          height: 20,
        ),
        historic.isEmpty
            ? SizedBox(
                height: 20,
                child: Text('Historial Vacio...',
                    style: TextStyle(color: TextColor(lightColor).color())),
              )
            : IconButton(
                onPressed: () {
                  historicHandler();
                },
                icon: Icon(Icons.delete,
                    color: !lightColor ? Colors.red : Colors.black)),
        ..._createHistoric(lightColor, availableWidth, mode)
      ],
    );
  }

  List<Widget> _createHistoric(bool lightColor, double width, String mode) {
    return historic
        .map((e) => HistoryCalculation(lightColor, e, width))
        .toList();
  }
}
