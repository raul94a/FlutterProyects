import 'package:flutter/material.dart';
import 'package:prueba_api/provider/cliente_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int cliente = 10;
  void increment() {
    setState(() {
      cliente++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: FutureBuilder(
                future: ClienteProvider.getCliente(cliente),
                initialData: [],
                builder: (context, AsyncSnapshot snapshot) {
               

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.data == null) {
                    return Center(
                      child: Text('La id introducida no es correcta'),
                    );
                  } else {
                    String nombre = snapshot.data['nombre'];
                    String id = snapshot.data['id'];
                    String correo = snapshot.data['correo'];
                    return Prueba(id, nombre, correo);
                  }
                })),
        floatingActionButton:
            FloatingActionButton(child: Icon(Icons.add), onPressed: increment));
  }
}

class Prueba extends StatelessWidget {
  String id;
  String nombre;
  String correo;
  Prueba(this.id, this.nombre, this.correo);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Text('$id   $nombre   $correo'),
    );
  }
}
