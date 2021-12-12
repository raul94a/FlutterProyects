import 'package:flutter/material.dart';
import 'package:proyecto91121/config/app_config.dart';

class FutbolPage extends StatefulWidget {
  @override
  _FutbolPageState createState() => _FutbolPageState();
}

class _FutbolPageState extends State<FutbolPage> {
  void showDiag(String nombre) {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('¿Quién soy?'),
              content: Text(nombre),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close'))
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('FUTBOL'),
    );
    final appBarHeight = appBar.preferredSize.height;
    final topHeight = MediaQuery.of(context).padding.top;
    final Size screenSize = MediaQuery.of(context).size;
    final double _availableHeight =
        screenSize.height - (topHeight + appBarHeight);
    final double _availableWidth = screenSize.width;
    bool wideMode = _availableWidth >= 400;
    print(_availableHeight);
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: _availableWidth,
          height: _availableHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/furbo.jpeg'), fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Center(
                  child: GestureDetector(
                    onTap: () => showDiag(firstRow['nombre'] as String),
                    child: CircleAvatar(
                      child: Column(
                        children: [
                          Text('${firstRow['num']}'),
                          Text(firstRow['abbr'] as String)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //mapeo la config para crear cada fila de la alineación, a excepción del portero
              ...config.map((e) => SizedBox(
                    height: wideMode
                        ? _availableWidth * 0.09
                        : _availableHeight * 0.27,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          //este segundo mapping es necesario porque dentro de cada posición del array hay un Map
                          //por tanto el map es necesario para construir CADA elemento del ROW
                          e
                              .map((el) => GestureDetector(
                                    onTap: () =>
                                        {showDiag(el['nombre'] as String)},
                                    child: CircleAvatar(
                                      radius: 25,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('${el['num']}'),
                                          Text(el['abbr'] as String)
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
