import 'package:ejercicio_clase/models/cliente_model.dart';
import 'package:ejercicio_clase/services/clientes_provider.dart';
import 'package:ejercicio_clase/widgets/lista_clientes.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //cargar los datos iniciales de mi aplicacion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, 'search'),
              icon: Icon(Icons.search))
        ],
      ),
      body: _ClientesBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //llamamos al post de codeigniter... para hacer un insert to en la tabla de las bd
          Navigator.pushNamed(context, 'add');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ClientesBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ClientesProvider.get(),
      initialData: [],
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('Cargando data...'),
          );
        } else {
          print(snapshot);
          return ListaClientes(snapshot.data);
        }
      },
    );
  }
}
