import 'dart:convert';
import 'package:http/http.dart' as http;

class PruebaProvider {
  static Uri uri = Uri.parse(
      'http://192.168.23.192/restful/index.php/prueba_flutter/avatar/');
  static String endpoint =
      'http://192.168.23.192/restful/index.php/prueba_flutter/avatar/';
  static Future<dynamic> get(int id) async {
    final res = await http.get(Uri.parse('$endpoint$id')).then((value) => jsonDecode(value.body));
    return res;
  }
}
