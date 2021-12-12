import 'package:flutter/material.dart';

class CardOferta extends StatelessWidget {
  String imagen;
  String text;
  CardOferta(this.imagen, this.text);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2 - 5,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Image(
              image: AssetImage(imagen),
            ),
          ),
        ),
        Positioned(left: 25, top: 25, child: Text(text))
      ],
    );
  }
}
