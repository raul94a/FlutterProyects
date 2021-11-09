import 'package:flutter/material.dart';

class TextColor {
  bool lightColor;
  TextColor(this.lightColor);
  
  Color color() {
    return lightColor ? Colors.black : Colors.white;
  }

  Color borderColor() {
    return lightColor ? Colors.black : Color.fromRGBO(38, 160, 218, 1);
  }
}
