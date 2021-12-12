import 'package:exament3/widgets/card_oferta.dart';
import 'package:flutter/material.dart';

class OfertaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Oferta academica'),
          backgroundColor: Colors.indigo,
        ),
        body: Column(
          children: [
            Row(
              children: [
                CardOferta('assets/ESO-1.png', 'ESO'),
                CardOferta('assets/bachillerato.jpg', 'Bachillerato')
              ],
            ),
            Row(
              children: [
                CardOferta('assets/dam.png', 'DAM'),
                CardOferta('assets/mantenimiento.jpg', 'Mantenimiento')
              ],
            ),
            Row(
              children: [
                CardOferta('assets/modlessuperiors.jpg', 'Moldes superior'),
                CardOferta('assets/medio.jpg', 'Moldes medio')
              ],
            )
          ],
        ));
  }
}
