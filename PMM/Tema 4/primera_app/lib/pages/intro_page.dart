import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _selectedTab = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  //SIMULAMOS UNA EXTRACCIÓN DE DATA DEL INTERNET
  final data = [
    {"icon": Icons.ac_unit, "name": "OPCION 1"},
    {"icon": Icons.grade, "name": "OPCION 2"},
    {"icon": Icons.event, "name": "OPCION 3"},
    {"icon": Icons.air_rounded, "name": "OPCION 4"},
    {"icon": Icons.face, "name": "OPCION 5"},
    {"icon": Icons.bolt, "name": "OPCION 6"},
    {"icon": Icons.book, "name": "OPCION 7"},
    {"icon": Icons.lock, "name": "OPCION 8"},
    {"icon": Icons.ac_unit, "name": "OPCION 9"},
    {"icon": Icons.grade, "name": "OPCION 10"},
    {"icon": Icons.event, "name": "OPCION 11"},
    {"icon": Icons.air_rounded, "name": "OPCION 12"},
    {"icon": Icons.face, "name": "OPCION 13"},
    {"icon": Icons.bolt, "name": "OPCION 14"},
    {"icon": Icons.book, "name": "OPCION 15"},
    {"icon": Icons.lock, "name": "OPCION 16"}
  ];

  @override
  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(52, 54, 101, 1),
        Color.fromRGBO(35, 37, 57, 1),
      ], begin: FractionalOffset(0, 0.6), end: FractionalOffset(0, 1))),
    );

    final cajaRosa = Transform.rotate(
        angle: 15,
        child: Container(
          height: 360,
          width: 360,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(85),
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(241, 142, 172, 1),
                Color.fromRGBO(236, 98, 188, 1)
              ])),
        ));
    return Stack(
      children: [gradiente, Positioned(top: -125, child: cajaRosa)],
    );
  }

  Widget _titulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Menú opciones',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Seleccione la opción que desee',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                )),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('HOLA')),
      body: Stack(
        children: [
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                _titulo(),
                _botones(),
              ],
            ),
          )
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        elevation: 20,
        //backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.amber,
        selectedIconTheme: IconThemeData(color: Colors.pinkAccent),
        selectedFontSize: 14,
        unselectedItemColor: Colors.black54,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        onTap: _selectPage,
        unselectedFontSize: 11,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.today,
                // color: Colors.black,
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today,
                // color: Colors.black,
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bubble_chart,
                // color: Colors.black,
              ),
              title: Container()),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.supervised_user_circle,
                // color: Colors.black,
              ),
              title: Container())
        ],
      ),
    );
  }

  Widget _crearBoton(IconData icon, String name) {
    return Container(
      height: 180,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(62, 66, 107, 0.7)),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.pinkAccent,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          Text('$name', style: TextStyle(color: Colors.pinkAccent)),
          SizedBox(height: 5)
        ],
      ),
    );
  }

  Widget _botones() {
    List<TableRow> list = [];
    for (var i = 0; i < (data.length); i += 2) {
      list.add(TableRow(children: [
        _crearBoton(data[i]['icon'] as IconData, data[i]['name'] as String),
        _crearBoton(
            data[i + 1]['icon'] as IconData, data[i + 1]['name'] as String)
      ]));
    }
    return Table(children: list);
  }
}
