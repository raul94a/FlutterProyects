import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  @override
  final opciones = ['1 - Fotos', '2 - Avatars', '3- Ubicacion', '4 - Perfiles'];
  final subtitulos = [
    'Mira tus fotos',
    'Cambia tu avatar',
    'Cambia tu ubicación',
    'Información de tu perfil'
  ];
  final avatars = [
    Icon(Icons.photo),
    Icon(Icons.face_retouching_natural_outlined),
    Icon(Icons.location_city),
    Icon(Icons.person_off_outlined)
  ];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('APP COMPONENTES'),
        ),
        body: ListView(children: _crearItemsCorta()));
  }

  List<Widget> _crearItems() {
    List<Widget> lista = [];
    int contador = 0;

    for (String opcion in opciones) {
      lista.add(ListTile(
        title: Text(opcion),
        subtitle: Text(subtitulos[contador]),
        leading: avatars[contador],
        trailing: Icon(Icons.arrow_right_sharp),
      ));
      lista.add(Divider());
      contador++;
    }
    return lista;
  }

  dynamic _crearItemsCorta() {
    int contador = -1;
    return opciones.map((e) {
      contador++;
      return Column(
        children: [
          ListTile(
            title: Text(e),
            subtitle: Text(subtitulos[contador]),
            leading: avatars[contador],
            trailing: Icon(Icons.arrow_right_sharp),
          )
        ],
      );
    }).toList();
  }
}
