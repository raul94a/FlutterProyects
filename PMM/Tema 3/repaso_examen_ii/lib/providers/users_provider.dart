import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repaso_examen_ii/config/config.dart';

class UsersProvider {
  static Uri uri =
      Uri.parse('https://carlosprofe.synology.me/pedro_rest/index.php/usuarioscasa/obtener');
  static String endpointProduct =
      'https://carlosprofe.synology.me/pedro_rest/index.php/usuarioscasa/usuario/';
  static Future<dynamic> getAll() async {
    dynamic res =
        await http.get(uri).then((value) => jsonDecode(value.body));

    return res;
  }

  static Future<Map<String, dynamic>> getUser(String id) async {
    Uri url = Uri.parse('$endpointProduct$id');

    return await http.get(url).then((value) => jsonDecode(value.body));
  }
}

// void main(List<String> args) async {
//   print(await UsersProvider.getAll());
//   print(await UsersProvider.getUser('2'));
// }
