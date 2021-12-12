import 'package:flutter/material.dart';
import 'package:proyecto91121/pages/alert.dart';
import '../provider/manu_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APPCOMPONENTES'),
      ),
      body: _lista(),
    );
  }

  dynamic _lista() {
    return FutureBuilder(
        future: menuProvider.cargarDatos(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(children: _listaItems(snapshot.data!, context));
        });
  }

  dynamic _crearLista() => [
        ListTileTheme(child: Text('Prueba')),
        ListTileTheme(child: Text('Prueba')),
        ListTileTheme(child: Text('Prueba')),
        ListTileTheme(child: Text('Prueba')),
        ListTileTheme(child: Text('Prueba')),
        ListTileTheme(child: Text('Prueba')),
        ListTileTheme(child: Text('Prueba')),
        ListTileTheme(child: Text('Prueba')),
        ListTileTheme(child: Text('Prueba')),
        ListTileTheme(child: Text('Prueba')),
      ];

  IconData getIcon(e) {
    return ('$Icons.$e' as IconData);
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    Map<String, IconData> config = {
      "add_alert": Icons.add_alert,
      "sports_soccer": Icons.sports_soccer,
      "accessibility": Icons.accessibility,
      "folder_open": Icons.folder_open,
      "content_copy": Icons.content_copy,
      "input": Icons.input,
      "tune": Icons.tune,
      "list": Icons.list,
      "supervised_user_circle": Icons.supervised_user_circle,
      "device_unknown": Icons.device_unknown
    };
    data.forEach((element) {
      //IconData icon = ("Icons." + element['icon']) as IconData;
      String icon = element["icon"];
      final widgetTemp = ListTile(
        title: Text(element['texto']),
        leading: Icon(config[element["icon"]], color: Colors.blue),
        trailing: Icon(Icons.arrow_right_alt, color: Colors.blue),
        onTap: () {
          Navigator.pushNamed(context, element['ruta']);
        },
      );
      opciones.add(widgetTemp);
      opciones.add(Divider());
    });
    return opciones;
  }
}
