import 'package:flutter/material.dart';

class Infinito extends StatefulWidget {
  @override
  _InfinitoState createState() => _InfinitoState();
}

class _InfinitoState extends State<Infinito> {
  List<int> lista = [];
  int ultimoItem = 0;
  ScrollController _controllador = ScrollController();

  void initState() {
    super.initState();
    _agregar();

    _controllador.addListener(() {
      if (_controllador.position.pixels ==
          _controllador.position.maxScrollExtent) {
        print('llegue abajo');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _crearList());
  }

  Widget _crearList() {
    return ListView.builder(
        controller: _controllador,
        itemCount: lista.length,
        itemBuilder: (_, index) {
          var temp = lista[index].toString();
          return FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image:
                  NetworkImage('https://picsum.photos/id/$temp/500/300.jpg'));
        });
  }

  void _agregar() {
    for (var i = 0; i < 10; i++) {
      setState(() {
        ultimoItem++;
        lista.add(ultimoItem);
      });
    }
  }
}
