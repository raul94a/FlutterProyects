import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  void showDiag() {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hola desde'),
              content: Text('Este magnífico dialogo'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('alert page'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Text('HOLA MUNDO DESDE ALERT PAGE'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDiag();
        },
        child: Icon(Icons.backpack),
      ),
    );
  }
}
