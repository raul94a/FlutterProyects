import 'package:ejercicio_clase/pages/home_page.dart';
import 'package:ejercicio_clase/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: appRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromRGBO(55, 57, 84, 1),
      ),
      home: MyHomePage(),
    );
  }
}
