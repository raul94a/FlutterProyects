import 'package:flutter/material.dart';

BoxDecoration customBoxDecoration() {
  return BoxDecoration(
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(25, 25, 25, 0.99),
        Color.fromRGBO(25, 25, 25, 0.99),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(25));
}

BoxDecoration customBoxDecorationLightBlack() {
  return BoxDecoration(
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(25, 25, 25, 0.99),
        Color.fromRGBO(25, 25, 25, 0.75),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(25));
}
