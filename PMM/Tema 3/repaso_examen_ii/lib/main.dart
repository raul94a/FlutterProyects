import 'package:flutter/material.dart';
import 'package:repaso_examen_ii/pages/products_page.dart';
import 'package:repaso_examen_ii/providers/colores_provider.dart';
import 'package:repaso_examen_ii/providers/fuentes_provider.dart';
import 'package:repaso_examen_ii/providers/routes_provider.dart';
import 'package:repaso_examen_ii/routes/routes.dart';
import 'config/config.dart';
import 'providers/titulos_provider.dart';

void main() async {
  //aqui nos traermos todo
  String? colorActivo = await ColoresProvider.get();
  Color? color = colores[colorActivo] as Color;
  print(color);
  color = color == null ? Colors.blue : color;
  List<dynamic> fonts = await FuentesProvider.get();
  List<dynamic> titles = await TitulosProvider.get();
  print(fonts);
  print(titles);
  runApp(MyApp(color, fonts, titles));
}

class MyApp extends StatelessWidget {
  final color;
  final fontSize;
  final titles;
  MyApp(this.color, this.fontSize, this.titles);
  // List<Map<String, dynamic>> routes;
  // //recogemos las rutas
  // MyApp(this.routes);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: applicationRoutes(context, fontSize, titles),
      initialRoute: 'splash',
      theme: ThemeData(
        primarySwatch: color,
      ),
      home: ProductsPage(fontSize, titles),
    );
  }
}
