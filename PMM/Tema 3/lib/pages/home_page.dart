import 'package:exament3/config/app_icons.dart';
import 'package:exament3/providers/docentes_provider.dart';
import 'package:exament3/providers/routes_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: _NavigationBuilder());
  }
}

class _NavigationBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RoutesProvider.get(),
        initialData: [],
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Cargando las rutas'),
            );
          } else {
            print(snapshot.data);
            return _RoutesList(snapshot.data);
          }
        });
  }
}

class _RoutesList extends StatelessWidget {
  List<Map<String, dynamic>> routes;
  _RoutesList(this.routes);
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: routes.map((e) {
      final subtitle = e['subtitle'];
      return GestureDetector(
        onTap: () async {
          if (e['page'] == 'docentes_page') {
            final docentes = await DocentesProvider.get();
            Navigator.pushNamed(context, e['page'], arguments: docentes);
          } else {
            Navigator.pushNamed(context, e['page']);
          }
        },
        child: Container(
            child: ListTile(
                leading: Icon(AppIcons.icons[e['icon']]),
                title: Text(e['text']),
                subtitle: subtitle != null ? Text(subtitle) : Text(''))),
      );
    }).toList());
  }
}
