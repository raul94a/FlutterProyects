import 'dart:convert';

import 'package:flutter/services.dart';

class MenuProvider {
  List<dynamic> opciones = [];

  _MenuProvider() {
    cargarDatos();
  }

  Future<List<dynamic>> cargarDatos() async {
    await rootBundle.loadString('assets/menu.json').then((value) {
      Map mapa = jsonDecode(value);
      // print(mapa);
      opciones = mapa['rutas'];

     
    });
    return opciones;
  }
}

// final menu = _MenuProvider();
