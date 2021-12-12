import 'package:flutter/material.dart';

class InputLogin extends StatelessWidget {
  String hintText;
  String helperText;
  String labelText;
  Function(String) inputFunction;
  VoidCallback checkButton;
  bool pass;

  InputLogin(this.hintText, this.helperText, this.labelText, this.inputFunction,
      this.checkButton, this.pass);
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: pass,
      decoration: InputDecoration(
          hintText: hintText,
          helperText: helperText,
          labelText: labelText,
          //prefixText: 'Nombre: ',

          icon: Icon(Icons.app_registration),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      onChanged: (value) {
        inputFunction(value);
        checkButton();
      },
    );
  }
}
