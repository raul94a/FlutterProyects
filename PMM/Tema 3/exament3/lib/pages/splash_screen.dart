import 'dart:async';

import 'package:exament3/providers/roles_provider.dart';
import 'package:flutter/material.dart';

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

  _configApplication() async {
    List<dynamic> roles = await RolesProvider.get();
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, 'login', arguments: roles);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(70, 200, 245, 0.85)),
        height: 450,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/logo_insti2.jpg')),
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
