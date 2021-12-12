import 'package:ejercicio_clase/models/cliente_model.dart';
import 'package:flutter/material.dart';

class ListaClientes extends StatelessWidget {
  final List<Cliente> clientes;
  const ListaClientes(this.clientes);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //INFO DE TEXTO
                      Container(
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(237, 230, 241, 1))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: clienteData(clientes, index),
                          ),
                        ),
                      ),

                      Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.white),
                                BoxShadow(color: Colors.black)
                              ],
                              border: Border.all(
                                  color: Color.fromRGBO(237, 240, 251, 1),
                                  width: 2)),
                          width: 150,
                          height: 150,
                          child: Image(
                            image: AssetImage('assets/unknown.jpg'),
                            fit: BoxFit.fill,
                          )),
                      //LA FOTO
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'cliente',
                              arguments: clientes[index]);
                        },
                        child: Text('VER INFO',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black))))
              ],
            ),
          );
        });
  }

  List<Widget> clienteData(List<Cliente> clientes, index) {
    return [
      Text(clientes[index].nombre!, textAlign: TextAlign.center),
      Text(clientes[index].correo!, textAlign: TextAlign.center),
      Text(clientes[index].pais!, textAlign: TextAlign.center),
      Text(clientes[index].telefono1!, textAlign: TextAlign.center),
      Text(clientes[index].telefono1!, textAlign: TextAlign.center),
      Text(clientes[index].zip!, textAlign: TextAlign.center),
    ];
  }
}
