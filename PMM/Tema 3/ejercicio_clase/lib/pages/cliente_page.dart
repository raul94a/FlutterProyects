import 'package:ejercicio_clase/models/cliente_model.dart';
import 'package:flutter/material.dart';

class ClientePage extends StatelessWidget {
  const ClientePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cliente = ModalRoute.of(context)!.settings.arguments as Cliente;

    return Scaffold(
      appBar: AppBar(title: Text('${cliente.nombre}')),
      body: Column(
        children: [
          //foto
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.4,
              child: Image(
                image: AssetImage('assets/unknown.jpg'),
                fit: BoxFit.fill,
              )),
          //datos cliente
          _ContenedorDatosCliente(clienteCampos, clienteData, cliente),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //llamamos al delete de codeigniter, pasándole la id este usuario...
        },
        child: Icon(Icons.delete),
      ),
    );
  }

  List<Widget> clienteData(Cliente cliente) {
    return [
      Text(cliente.id!, textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text('${cliente.activo! == '1' ? 'Si' : 'No'}',
          textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text(cliente.nombre!, textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text(cliente.correo!, textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text(cliente.telefono1!, textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text(cliente.telefono1!, textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text(cliente.direccion!, textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text(cliente.zip!, textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text(cliente.pais!, textAlign: TextAlign.right),
    ];
  }

  List<Widget> clienteCampos() {
    return const [
      Text('id: ', textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text('activo: ', textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text('nombre: ', textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text('correo: ', textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text('telefono 1: ', textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text('telefono 2: ', textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text('direccion: ', textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text('zip: ', textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
      Text('pais: ', textAlign: TextAlign.right),
      SizedBox(
        height: 20,
      ),
    ];
  }
}

class _ContenedorDatosCliente extends StatelessWidget {
  final clienteCampos;
  final clienteData;
  final cliente;
  _ContenedorDatosCliente(this.clienteCampos, this.clienteData, this.cliente);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: clienteCampos(),
          ),
          Column(
            children: clienteData(cliente),
          )
        ],
      ),
    );
  }
}
