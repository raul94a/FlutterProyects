import 'package:flutter/material.dart';
import 'package:gastos_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gastos personales',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.light(
            secondary: Colors.indigo, secondaryVariant: Colors.white),
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
            backgroundColor: Color.fromRGBO(48, 43, 99, 1),
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 23,
              fontWeight: FontWeight.bold,
            )),
        textTheme: TextTheme(
            headline1: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      home: HomePage(),
    );
  }
}
