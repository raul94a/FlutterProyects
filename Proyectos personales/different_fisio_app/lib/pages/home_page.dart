import 'package:different_fisio_app/config/app_config.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final config = ModalRoute.of(context)!.settings.arguments
        as List<Map<String, dynamic>>;
    print(config);
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(44, 62, 80, 0.5),
          Colors.black.withOpacity(0.25)
        ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                'assets/img/logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Table(
              children: [..._buildTableRows(config)],
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildButton(IconData icon, String nombre, String ruta) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ruta);
      },
      child: Container(
          width: 150,
          height: 150,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(2, 56, 110, 1),
                Color.fromRGBO(0, 18, 77, 0.85),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.menu),
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                nombre,
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
    );
  }

  List<TableRow> _buildTableRows(List config) {
    List<TableRow> rows = [];
    for (int i = 0; i < config.length; i += 2) {
      Widget uno = _buildButton(iconConfig[config[i]['icono']] as IconData,
          config[i]['nombre'], config[i]['ruta']);
      Widget? dos = null;
      //todas las tablerow deben tener la misma integridad...imagenemos que vienen impares o algo asi
      //debemos comprobar que el segundo widget, en este caso, ojo, NO supere el indice MAXIMO
      //En el caso de que lo supere el widget es null y se devuelve un container vacío
      //En el caso de que no, se devuelve el widget de _buildButton
      if (i + 1 < config.length) {
        dos = _buildButton(iconConfig[config[i + 1]['icono']] as IconData,
            config[i + 1]['nombre'], config[i + 1]['ruta']);
      }
      TableRow table = TableRow(children: [uno, dos ?? Container()]);
      rows.add(table);
    }
    return rows;
  }
}
