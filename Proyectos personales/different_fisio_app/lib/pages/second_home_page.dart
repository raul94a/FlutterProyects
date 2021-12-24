import 'package:different_fisio_app/config/app_config.dart';
import 'package:flutter/material.dart';

import 'admin_page.dart';
import 'user_page.dart';

class SecondHomePage extends StatefulWidget {
  @override
  _SecondHomePageState createState() => _SecondHomePageState();
}

class _SecondHomePageState extends State<SecondHomePage> {
  int _index = 0;
  void _selectPage(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //configuración global
    final List<dynamic> config =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    // print(config);
    //recuperar items de admin
    final List<dynamic> adminConfig = config.where((element) {
      return element['admin'];
    }).toList();
    // print(adminConfig);
    final List<dynamic> bottomBarConfig =
        config.where((e) => e['bottomBar']).toList();
    // print(bottomBarConfig);

    final List<dynamic> userConfig =
        config.where((e) => !e['admin'] && !e['bottomBar']).toList();
    // print(userConfig);
    //TENEMOS QUE CREAR LA LISTA DE WIDGETS
    List<Widget> pages = [AdminPage(adminConfig), UserPage(userConfig)];
    List<String> appbarTitle = ['Admin Page', 'User page'];
    return Scaffold(
        appBar: AppBar(title: Text(appbarTitle[_index])),
        body: pages[_index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: _selectPage,
          items: [..._buildNavegacion(bottomBarConfig)],
        ));
  }

  List<BottomNavigationBarItem> _buildNavegacion(bottomBarConfig) {
    List<BottomNavigationBarItem> botones = [];
    for (var c in bottomBarConfig) {
      var boton = BottomNavigationBarItem(
          icon: Icon(iconConfigTwo[c['icono']]),
          label: 'OPCION ${c['nombre']}');
      botones.add(boton);
    }
    return botones;
  }
}
