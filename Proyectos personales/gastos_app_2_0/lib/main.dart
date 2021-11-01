import 'package:flutter/material.dart';
import './pages/home_page.dart';
import 'models/storage.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'gastos personales',
      theme: ThemeData(
          fontFamily: 'Raleway',
          primaryColor: Colors.blue,
          textTheme: const TextTheme(
            bodyText1: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18,
                fontWeight: FontWeight.w700),
            bodyText2: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            button: TextStyle(
                color: Color.fromRGBO(50, 31, 74, 0.98),
                fontSize: 19,
                fontWeight: FontWeight.bold),
            //Money inside Border
            headline1: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            //Transaction title
            headline2: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            //Date
            headline3: TextStyle(color: Colors.grey, fontSize: 18),
            //ChartBart Money and day
            headline4: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
            headline5: TextStyle(color: Colors.blue),
            headline6: TextStyle(color: Colors.red),
          ),
          colorScheme: const ColorScheme.highContrastLight(
              primary: Colors.deepPurple,
              secondary: Color.fromRGBO(56, 11, 74, 1),
              onSecondary: Colors.white),
          iconTheme: const IconThemeData(color: Colors.white),
          appBarTheme: const AppBarTheme(
              titleTextStyle:
                  TextStyle(fontSize: 25, fontWeight: FontWeight.w700))),
      home: HomePage(Storage()),
    );
  }
}
