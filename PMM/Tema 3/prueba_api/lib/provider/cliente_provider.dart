import 'dart:convert';
import 'package:http/http.dart' as http;

class ClienteProvider {
  static Uri uri =
      Uri.parse('http://192.168.23.192/restful/index.php/pruebas_db/cliente/');
  static String endpoint =
      'http://192.168.23.192/restful/index.php/pruebas_db/cliente/';

  static Future<dynamic> getCliente(int id) async {
    Uri url = Uri.parse('$endpoint$id');
    return await http.get(url).then((value) => jsonDecode(value.body));
  }
}