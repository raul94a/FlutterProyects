import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repaso_examen/pages/home_page.dart';
import 'package:repaso_examen/pages/product.dart';
import 'package:repaso_examen/pages/products_page.dart';
import 'package:repaso_examen/providers/routes_provider.dart';

Map<String, Widget Function(BuildContext)> routes() => {
      "home": (BuildContext context) => HomePage(),
      "products": (BuildContext context) => ProductsPage(),
      "products/product": (BuildContext context) => ProductPage()
    };

Future<Map<String, Widget Function(BuildContext)>> getAppRoutes() async {
  Map<String, Widget Function(BuildContext)> mapa = {};
  List<String> rutas = await RouterProvider.get();
  Map<String, Widget Function(BuildContext)> config = routes();
  rutas.forEach((element) {
    if (config.containsKey(element)) {
      mapa[element] = config[element] as Widget Function(BuildContext);
    }
  });
  return mapa;
}



Future<List<String>> listaRutas() async {
  final map = await getAppRoutes();
  List<String> rutas = [];
  map.forEach((key, value) {
    rutas.add(key);
  });
  return rutas;
}


 List<String> rutas =[];
final res = listaRutas().then((value) => rutas = value);
