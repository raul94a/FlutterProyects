import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  @override
  final appBarAndPaddingHeight;
  NoData(this.appBarAndPaddingHeight);

  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size.height;
    final availableHeight = _screenSize - appBarAndPaddingHeight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: availableHeight * 0.05,
        ),
        Center(
            child: Container(
                width: availableHeight * 0.3,
                child: Image.asset('assets/img/waiting.png'))),
        SizedBox(
          height: availableHeight * 0.05,
        ),
        Text(
          'No hay Transacciones aún',
        )
      ],
    );
  }
}
