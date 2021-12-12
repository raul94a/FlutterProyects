import 'package:ejercicio_clase/models/cliente_model.dart';
import 'package:ejercicio_clase/services/clientes_provider.dart';
import 'package:ejercicio_clase/widgets/input.dart';
import 'package:ejercicio_clase/widgets/lista_clientes.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String nombre = '';
  String correo = '';
  String pais = '';
  String zip = '';
  List<Cliente> clientes = [];
  void setNombre(value) => setState(() => nombre = value);
  void setCorreo(value) => setState(() => correo = value);
  void setPais(value) => setState(() => pais = value);
  void setZip(value) => setState(() => zip = value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Page')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              InputField('Nombre', 'Introduce el nombre', 'Nombre', setNombre),
              InputField('Correo', 'Introduce el Correo', 'Correo', setCorreo),
              InputField('Pais', 'Introduce el Pais', 'Pais', setPais),
              InputField('Zip', 'Introduce el Zip', 'Zip', setZip),
              Container(
                width: MediaQuery.of(context).size.width - 200,
                child: ElevatedButton(
                    onPressed: () async {
                      //se llama al post
                      List<Cliente> listaClientes =
                          await ClientesProvider.searchClientes(
                              nombre, correo, zip, pais);
                      setState(() {
                        clientes = listaClientes;
                        // nombre = '';
                        // correo = '';
                        // pais = '';
                        // zip = '';
                      });
                      print('$nombre$pais$correo$zip');
                    },
                    child: Text('enviar')),
              ),
              if (!clientes.isEmpty)
                Container(
                  height: 300,
                  child: ListaClientes(clientes),
                )
            ],
          ),
        ),
      ),
    );
  }
}
