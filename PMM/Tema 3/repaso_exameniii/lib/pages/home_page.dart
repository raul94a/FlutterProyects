import 'package:flutter/material.dart';
import 'package:repaso_exameniii/config/menu_incos.dart';
import 'package:repaso_exameniii/providers/menu_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dsf'),
      ),
      body: Center(
          child: FutureBuilder(
        future: MenuProvider().cargarDatos(),
        initialData: [],
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            print(snapshot.data);
            return _Menu(snapshot.data);
          }
        },
      )),
    );
  }
}

class _Menu extends StatelessWidget {
  final data;
  _Menu(this.data);
  @override
  Widget build(BuildContext context) {
    print(MenuIcons.icons['add_alert']);
    return ListView(
        children: (data as List).map((e) {
      final icon = e['icon'];
      final texto = e['texto'];
      final ruta = e['ruta'];
      return Container(
        width: double.infinity,
        height: 50,
        child: ListTile(
          leading: Icon(MenuIcons.icons[icon]),
          title: Text(texto),
          trailing: IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                Navigator.pushNamed(context, ruta);
              }),
        ),
      );
    }).toList()

        // (data as List).
        // Container(
        //   width: double.infinity,
        //   height: 50,
        //   child: ListTile(
        //     leading: Icon(MenuIcons.icons[data['icon']]),
        //     title: data['texto'],
        //     trailing: Icon(Icons.arrow_right),
        //   ),
        // ),

        );
  }
}
