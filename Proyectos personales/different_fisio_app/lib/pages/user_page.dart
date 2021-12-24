import 'package:different_fisio_app/config/app_config.dart';
import 'package:different_fisio_app/config/custom_box_dec.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  String appbarTitle = 'USER PAGE';
  final List<dynamic> config;
  UserPage(this.config);
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [..._buildTableRows(config, context)],
    );
  }

  Widget _buildButton(IconData icon, String ruta, context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ruta);
      },
      child: Container(
          width: 150,
          height: 150,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(15),
          decoration: customBoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                'OPCION',
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
    );
  }

  List<TableRow> _buildTableRows(List config, context) {
    List<TableRow> rows = [];
    for (int i = 0; i < config.length; i += 2) {
      Widget uno = _buildButton(iconConfigTwo[config[i]['icono']] as IconData,
          config[i]['nombre'], context);
      Widget? dos = null;
      //todas las tablerow deben tener la misma integridad...imagenemos que vienen impares o algo asi
      //debemos comprobar que el segundo widget, en este caso, ojo, NO supere el indice MAXIMO
      //En el caso de que lo supere el widget es null y se devuelve un container vacío
      //En el caso de que no, se devuelve el widget de _buildButton
      if (i + 1 < config.length) {
        dos = _buildButton(iconConfigTwo[config[i + 1]['icono']] as IconData,
            config[i + 1]['nombre'], context);
      }
      TableRow table = TableRow(children: [uno, dos ?? Container()]);
      rows.add(table);
    }
    return rows;
  }
}
