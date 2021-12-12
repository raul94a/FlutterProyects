import 'dart:convert';
import 'dart:io';
import 'package:ejercicio_clase/models/cliente_model.dart';
import 'package:http/http.dart' as http;

class ClientesProvider {
  static String ipCasa = '192.168.1.115';
  static String ipInsti = '192.168.100.253';
  static String ipMovil = '192.168.43.112';
  static Uri uri =
      Uri.parse('http://$ipMovil/restful/index.php/clientes/clientes/20');
  static String endpoint =
      'http://$ipMovil/restful/index.php/clientes/clientes/';
  static String endPointBusqueda =
      'http://$ipMovil/restful/index.php/clientes/cliente/';

  static Future<dynamic> get() async {
    final res = await http
        .get(
          uri, /*headers: {'x-api-key': '12345678'}*/
        )
        .then((value) => jsonDecode(value.body));
    print(res);
    List<Cliente> clientes = [];
    //Cliente? cliente = null;
    (res as List).forEach((element) {
      clientes.add(Cliente.fromJson(element));
    });
    return clientes;
  }

  static Future<dynamic> searchClientes(
      String nombreCliente, String correo, String zip, String pais) async {
    String endpointBusquedaCopia = endPointBusqueda;
    if (nombreCliente == '') {
      correo = '';
      zip = '';
      pais = '';
    } else if (correo == '') {
      endpointBusquedaCopia += nombreCliente;
    } else if (pais == '') {
      endpointBusquedaCopia += nombreCliente + '/' + correo;
    } else if (zip == '') {
      endpointBusquedaCopia += nombreCliente + '/' + correo + '/' + pais;
    } else {
      endpointBusquedaCopia +=
          nombreCliente + '/' + correo + '/' + pais + '/' + zip;
    }
    print(endpointBusquedaCopia);
    Uri uri = Uri.parse(endpointBusquedaCopia);
    final res = await http
        .get(
          uri, /*headers: {'x-api-key': '12345678'}*/
        )
        .then((value) => jsonDecode(value.body));
    List<Cliente> clientes = [];
    //Cliente? cliente = null;
    (res as List).forEach((element) {
      clientes.add(Cliente.fromJson(element));
    });
    endpointBusquedaCopia = endPointBusqueda;
    return clientes;
  }

  static Future<void> post(Cliente cliente) async {
    await http.post(Uri.parse(endPointBusqueda),
        headers: {
          "content-type": "application/json",
          'Accept': 'application/json',
          /*'x-api-key': '12345678',*/
        },
        body: jsonEncode(cliente.toJson()));
  }
}
