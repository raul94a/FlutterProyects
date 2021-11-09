import 'package:flutter/material.dart';

class AppBackground {
  bool lightColor;
  AppBackground(this.lightColor);
  BoxDecoration fondo() {
    List<Color> getAppColors() {
      if (lightColor) {
        return [Colors.white, Color.fromRGBO(250, 172, 168, 1)];
      }
      return [Color.fromRGBO(42, 55, 79, 1), Color.fromRGBO(41, 50, 60, 1)];
    }

    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: getAppColors()));
  }
}
