import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  String hintText;
  String helperText;
  String labelText;
  Function(String) inputFunction;
  //VoidCallback checkButton;

  InputField(
    this.hintText,
    this.helperText,
    this.labelText,
    this.inputFunction,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            helperText: helperText,
            labelText: labelText,
            icon: Icon(Icons.app_registration),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        onChanged: (value) {
          inputFunction(value);
        },
      ),
    );
  }
}
