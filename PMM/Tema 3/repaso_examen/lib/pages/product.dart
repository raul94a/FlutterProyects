import 'package:flutter/material.dart';
import 'package:repaso_examen/model/product_model.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //necesito el producto para generar la pagina
    final args = ModalRoute.of(context)!.settings.arguments as Product;
    return Text(args.nombre!);
  }
}
