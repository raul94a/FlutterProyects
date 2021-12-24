import 'package:examen_t4/pages/equipos_page.dart';
import 'package:examen_t4/pages/fav_page.dart';
import 'package:flutter/material.dart';

class MainNavPage extends StatefulWidget {
  //final List<dynamic> equipos;
  //final fav;
  // MainNavPage(/*this.equipos, /*this.fav*/*/);

  @override
  _MainNavPageState createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _index = 0;
  void _selectPage(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> paginas = [
      EquiposPage(/*widget.equipos*/),
      FavPage(/*widget.fav*/)
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(40, 40, 40, 0.99),
          title: Text(
            '${_index == 0 ? 'LaLiga Santander' : ' Jugadores favoritos'}',
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
        ),
        body: paginas[_index],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green.shade200,
          unselectedItemColor: Colors.white,
          currentIndex: _index,
          onTap: _selectPage,
          items: [..._buildNavegacion()],
        ));
  }

  List<BottomNavigationBarItem> _buildNavegacion() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Equipos'),
      BottomNavigationBarItem(
          icon: Icon(Icons.star_border_outlined), label: 'Favoritos')
    ];
  }
}
