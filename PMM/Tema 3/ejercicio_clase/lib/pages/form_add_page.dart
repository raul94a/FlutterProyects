import 'package:ejercicio_clase/models/cliente_model.dart';
import 'package:ejercicio_clase/services/clientes_provider.dart';
import 'package:ejercicio_clase/widgets/input.dart';
import 'package:flutter/material.dart';

class FormAddCliente extends StatefulWidget {
  @override
  _FormAddClienteState createState() => _FormAddClienteState();
}

class _FormAddClienteState extends State<FormAddCliente> {
  String telefono1 = '';
  String telefono2 = '';
  String direccion = '';
  String nombre = '';
  String correo = '';
  String pais = '';
  String zip = '';
  void setTelefono1(value) => setState(() => telefono1 = value);
  void setTelefono2(value) => setState(() => telefono2 = value);
  void setDireccion(value) => setState(() => direccion = value);
  void setNombre(value) => setState(() => nombre = value);
  void setCorreo(value) => setState(() => correo = value);
  void setPais(value) => setState(() => pais = value);
  void setZip(value) => setState(() => zip = value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Clinte'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              InputField('Nombre', 'Introduce el nombre', 'Nombre', setNombre),
              InputField('Telefono 1', 'Introduce el Telefono 1', 'Telefono 1',
                  setTelefono1),
              InputField('Telefono 2', 'Introduce el Telefono 2', 'Telefono 2',
                  setTelefono2),
              InputField('Correo', 'Introduce el Correo', 'Correo', setCorreo),
              InputField('Direccion', 'Introduce el Direccion', 'Direccion',
                  setDireccion),
              InputField('Zip', 'Introduce el Zip', 'Zip', setZip),
              InputField('Pais', 'Introduce el Pais', 'Pais', setPais),
              Container(
                width: MediaQuery.of(context).size.width - 200,
                child: ElevatedButton(
                    onPressed: () async {
                      //se llama al post
                      // String? id;
                      // String? nombre;
                      // String? activo;
                      // String? correo;
                      // String? zip;
                      // String? telefono1;
                      // String? telefono2;
                      // String? pais;
                      // String? direccion;
                      var cliente = Cliente(null, nombre, '1', correo, zip,
                          telefono1, telefono2, pais, direccion);
                      await ClientesProvider.post(cliente);
                      print('HOLA');
                    },
                    child: Text('enviar')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
