import 'dart:async';

import 'package:flutter/material.dart';
import 'package:repaso_examen_ii/providers/routes_provider.dart';

//aqui es donde las rutas deben ser cargadas antes de redirigirnos hacia
//la pagina principal /products
class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  

  double spacing = 1;
  void initState() {
    super.initState();
    // _setSpacing();
    _configApplication();
  }

  // Timer _setSpacing() {
  //   return _growLoading();
  // }

  // Timer _growLoading() {
  //   return Timer.periodic(Duration(milliseconds: 200), (Timer) {
  //     setState(() {
  //       spacing += 1;
  //     });
  //   });
  // }

  // void dispose() {
  //   super.dispose();
  //   _setSpacing().cancel();
  // }

  _configApplication() async {
    List<Map<String, dynamic>> routes = await RoutesProvider.getFromMySQL();

    await Future.delayed(Duration(seconds: 1));

    Navigator.pushReplacementNamed(context, 'products', arguments: routes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         colors: [Colors.orange, Colors.purple, Colors.red])),
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(70, 200, 245, 0.85)),
        height: 450,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/cat.gif',
                fit: BoxFit.fill,
              ),
              Text('Cargando...',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: spacing))
            ],
          ),
        ),
      ),
    ));
  }
}
