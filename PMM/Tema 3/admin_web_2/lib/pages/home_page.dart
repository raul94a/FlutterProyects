import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Menu')),
        body: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 2,
              childAspectRatio: 3 / 2),
          children: [
            Container(
              width: 200,
              height: 150,
              child: Text('Prueba'),
            ),
            Container(
              width: 200,
              height: 150,
              child: Text('Prueba'),
            ),
            Container(
              width: 200,
              height: 150,
              child: Text('Prueba'),
            )
          ],
        ));
  }
}
