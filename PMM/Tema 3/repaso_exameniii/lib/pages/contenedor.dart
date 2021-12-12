import 'dart:math';

import 'package:flutter/material.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  @override
  double width = 50;
  double height = 50;
  Color color = Colors.red;
  double w2 = 50;
  double h2 = 50;
  Color c2 = Colors.black;
  double w3 = 50;
  double h3 = 50;
  Color c3 = Colors.orange;

  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      cambiar();
      Future.delayed(Duration(seconds: 2)).then((value) {
        cambiar2();
        Future.delayed(Duration(seconds: 2)).then((value) {
          cambiar3();
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contendor'),
      ),
      body: Column(
        children: [
          contenedorAnimado(width, height, color),
          contenedorAnimado(w2, h2, c2),
          contenedorAnimado(w3, h3, c3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cambiar,
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  void cambiar() {
    setState(() {
      width = double.parse(Random().nextInt(150).toString());
      height = double.parse(Random().nextInt(150).toString());
      color = Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 1);
    });
  }

  void cambiar2() {
    setState(() {
      w2 = double.parse(Random().nextInt(150).toString());
      h2 = double.parse(Random().nextInt(150).toString());
      c2 = Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 1);
    });
  }

  void cambiar3() {
    setState(() {
      w3 = double.parse(Random().nextInt(150).toString());
      h3 = double.parse(Random().nextInt(150).toString());
      c3 = Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 1);
    });
  }
}

class contenedorAnimado extends StatelessWidget {
  final width;
  final height;
  final color;
  contenedorAnimado(this.width, this.height, this.color);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.only(top: 50),
      width: width,
      height: height,
      decoration: BoxDecoration(color: color),
    ));
  }
}
