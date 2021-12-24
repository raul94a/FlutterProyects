import 'package:different_fisio_app/pages/borrar_usuario_page.dart';
import 'package:different_fisio_app/pages/home_page.dart';
import 'package:different_fisio_app/pages/splash_page.dart';
import 'package:flutter/material.dart';

import 'pages/entrenamiento_page.dart';
import 'pages/gestion_rutas_page.dart';
import 'pages/insertar_producto_page.dart';
import 'pages/insertar_usuario_page.dart';
import 'pages/productos_page.dart';
import 'pages/second_home_page.dart';
import 'pages/usuarios_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      initialRoute: 'splash',
      routes: {
        'productos': (ctx) => ProductosPage(),
        'usuarios': (ctx) => UsuariosPage(),
        'borrar_usuario': (ctx) => BorrarUsuarioPage(),
        'gestion_rutas': (ctx) => GestionRutas(),
        'insertar_producto': (ctx) => InsertarProductoPage(),
        'insertar_usuario': (BuildContext context) => InsertarUsuarioPage(),
        'second': (BuildContext context) => SecondHomePage(),
        'entrenamiento': (BuildContext context) => EntrenamientoPage(),
        'splash': (BuildContext context) => SplashPage(),
        'home': (BuildContext context) => HomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: Icon(Icons.event_available)),
    );
  }
}
