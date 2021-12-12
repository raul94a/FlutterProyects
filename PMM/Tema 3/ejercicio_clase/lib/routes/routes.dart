import 'package:ejercicio_clase/pages/cliente_page.dart';
import 'package:ejercicio_clase/pages/form_add_page.dart';
import 'package:ejercicio_clase/pages/home_page.dart';
import 'package:ejercicio_clase/pages/search_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> appRoutes() => {
      'home': (BuildContext context) => MyHomePage(),
      'cliente': (BuildContext context) => ClientePage(),
      'search': (BuildContext context) => SearchPage(),
      'add': (BuildContext context) => FormAddCliente(),
    };
