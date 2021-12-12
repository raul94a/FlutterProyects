import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ContainerPage extends StatefulWidget {
  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  double _width = 50;
  double _height = 50;
  Color _color = Colors.blue;
  double _width2 = 50;
  double _height2 = 50;
  Color _color2 = Colors.blue;
  double _width3 = 50;
  double _height3 = 50;
  Color _color3 = Colors.blue;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8.0);
  Widget getWidget() {
    return AnimatedContainer(
        padding: EdgeInsets.all(50),
        margin: EdgeInsets.only(top: 50),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: _width,
        height: _height,
        color: _color);
  }

  Widget getWidget2() {
    return AnimatedContainer(
        padding: EdgeInsets.all(50),
        margin: EdgeInsets.only(top: 50),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: _width2,
        height: _height2,
        color: _color2);
  }

  Widget getWidget3() {
    return AnimatedContainer(
        padding: EdgeInsets.all(50),
        margin: EdgeInsets.only(top: 50),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: _width3,
        height: _height3,
        color: _color3);
  }

  List<Widget> lista = [];
  Widget? w1 = null;
  Widget? w2 = null;
  Widget? w3 = null;

  void initState() {
    super.initState();
    
      Future.delayed(Duration(seconds: 1)).then((value) => _cambiarForma());
      Future.delayed(Duration(seconds: 3)).then((value) => _cambiarForma2());
      Future.delayed(Duration(seconds: 5)).then((value) => _cambiarForma3());

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('COntainer'),
        ),
        body: Container(
          width: 500,
          child: SingleChildScrollView(
              child:
                  Column(children: [getWidget(), getWidget2(), getWidget3()])),
        ));
  }

  Future<dynamic> _cambiarForma() async {
    Timer(Duration(seconds: 3), () {});
    setState(() {
      _width = double.parse(Random().nextInt(300).toString());
      _height = double.parse(Random().nextInt(200).toString());
      _color = Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 1);
    });
    return;
  }

  _cambiarForma2() {
    setState(() {
      _width2 = double.parse(Random().nextInt(300).toString());
      _height2 = double.parse(Random().nextInt(200).toString());
      _color2 = Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 1);
    });
  }

  _cambiarForma3() {
    setState(() {
      _width3 = double.parse(Random().nextInt(300).toString());
      _height3 = double.parse(Random().nextInt(200).toString());
      _color3 = Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 1);
    });
  }

  Widget fut(sec) {
    return FutureBuilder(
        future: _cambiarForma(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            return AnimatedContainer(
                duration: Duration(seconds: sec),
                curve: Curves.fastOutSlowIn,
                width: _width,
                height: _height,
                color: _color);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
