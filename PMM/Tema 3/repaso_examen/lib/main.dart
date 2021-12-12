import 'package:flutter/material.dart';
import 'package:repaso_examen/pages/home_page.dart';
import 'package:repaso_examen/routes/routes.dart';

void main() async {
  Map<String, Widget Function(BuildContext)> rutas = await getAppRoutes();
  runApp(MyApp(rutas));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final rutas;
  MyApp(this.rutas);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: rutas,
     
      initialRoute: 'home',
      //onGenerateRoute: generatedRoutes,
      home: HomePage(),
    );
  }
}
