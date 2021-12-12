import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    _countdown();
  }

  _countdown() async {
    var dur = Duration(seconds: 3);
    return Timer(dur, () {
      Navigator.pushReplacementNamed(context, 'home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red, Colors.purple])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Center(
                child: Container(
                    padding: EdgeInsets.only(top: 50),
                    height: 350,
                    width: 350,
                    child: Image.asset('assets/giphy.gif')),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Entrando en otra dimensión...',
                style: TextStyle(fontSize: 25),
              ),
              Padding(padding: EdgeInsets.all(25)),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
