import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Center(
            child: Container(
                width: 200, child: Image.asset('assets/img/waiting.png'))),
        SizedBox(
          height: 50,
        ),
        Text(
          'No hay Transacciones aún',
          //style: TextStyle(fontSize: 25, fontFamily: 'Fast 99'),
        )
      ],
    );
  }
}
