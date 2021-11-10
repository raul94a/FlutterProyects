import 'package:flutter/material.dart';
import 'package:proyecto91121/pages/home_page.dart';
import 'package:proyecto91121/pages/home_page_temp.dart';
import 'package:proyecto91121/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'home',
      routes: getAplicationRoutes(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: HomePage()),
    );
  }
}
