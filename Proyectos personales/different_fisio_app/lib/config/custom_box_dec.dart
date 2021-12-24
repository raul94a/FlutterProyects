import 'package:flutter/material.dart';

BoxDecoration customBoxDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(colors: [
        Color.fromRGBO(2, 56, 110, 1),
        Color.fromRGBO(0, 18, 77, 0.85),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(25));
}
