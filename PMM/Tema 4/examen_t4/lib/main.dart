import 'package:examen_t4/pages/jugador_detalle_page.dart';
import 'package:examen_t4/pages/main_nav_page.dart';
import 'package:examen_t4/services/code_igniter_service.dart';
import 'package:examen_t4/services/futbol_service.dart';
import 'package:flutter/material.dart';

import 'pages/equipos_page.dart';
import 'pages/fav_page.dart';
import 'pages/jugadores_page.dart';

void main() async {
  //List<dynamic> equipos = await FutbolService.getEquipos();
  // print(await FutbolService.getJugadoresEquipo(78));
  // List<dynamic> fav = await CodeIgniterService.get();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //final equipos;
  // final fav;
  MyApp(/*this.equipos,*/ /*this.fav*/);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        'main': (BuildContext context) => MainNavPage(),
        'equipos': (BuildContext context) => EquiposPage(),
        'favoritos': (ctx) => FavPage(/*fav*/),
        'jugadores': (BuildContext context) => JugadoresPage(),
        'jugador/detalle': (ctx) => JugadorDetallePage()
      },
      theme: MyThemeData().theme(),
      home: MainNavPage(/*fav*/),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('das')), body: Column());
  }
}

class MyThemeData {
  ThemeData theme() {
    return ThemeData(
        textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            headline1: TextStyle(color: Colors.white),
            headline4: TextStyle(
              color: Colors.white,
              fontSize: 24,
            )),
        backgroundColor: Color.fromRGBO(25, 25, 25, 0.85),
        primarySwatch: Colors.blue,
        canvasColor: Color.fromRGBO(25, 25, 25, 1));
  }
}
