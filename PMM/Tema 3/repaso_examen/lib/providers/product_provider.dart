import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:repaso_examen/model/product_model.dart';

class ProductProvider {
  static Uri uri = Uri.parse(
      'https://repasot3-default-rtdb.europe-west1.firebasedatabase.app/productos.json');
  static String endpoint =
      'https://repasot3-default-rtdb.europe-west1.firebasedatabase.app/productos';

  static Future<dynamic> get() async {
    final res = await http.get(uri).then((value) => jsonDecode(value.body));
    List<Product> productos = [];
    (res as Map)
        .forEach((key, value) => productos.add(Product.fromJson(value, key)));
    return productos;
  }
}
