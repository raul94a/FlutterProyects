import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final availableHeight;
  final availableWidth;
  final output;
  final enteredNumber;
  final equalPressed;
  final history;
  TextContainer(this.availableHeight, this.availableWidth, this.output,
      this.enteredNumber, this.equalPressed, this.history);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(availableWidth * 0.01),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 2),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.white])),
      width: availableWidth > 650 ? availableWidth * 0.5 : double.infinity,
      //esta será la altura que el contenedor de texto tendrá. Será el 25% del espacio disponible
      height: availableWidth > 650
          ? availableHeight * 0.20
          : availableHeight * 0.30,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              history,
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Text(
              equalPressed ? output : enteredNumber,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
