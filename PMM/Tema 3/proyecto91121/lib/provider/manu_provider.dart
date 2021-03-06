import 'dart:convert';

import 'package:flutter/services.dart';

class _MenuProvider {
  List<Map<String, dynamic>> opciones = [];

  _MenuProvider() {
    cargarDatos();
  }

  Future<List<Map<String, dynamic>>> cargarDatos() async {
    await rootBundle.loadString('assets/menu_opts.json').then((value) {
      Map mapa = jsonDecode(value);

      (mapa['rutas'] as List).forEach((a) => opciones.add(a));
      //opciones = mapa['rutas'] as List<Map<String,dynamic>>;
    });
   // print(opciones);
    return opciones;
  }
}

final menuProvider = _MenuProvider();
