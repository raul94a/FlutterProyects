import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repaso_examen_ii/config/config.dart';

class FuentesProvider {
  static Uri uri =
      Uri.parse('https://carlosprofe.synology.me/pedro_rest/index.php/fuente/obtener');

  static Future<dynamic> get() async {
    final List<dynamic> res = await http.get(uri).then((value) {
      // print(value.body);
      // print(jsonDecode(value.body).runtimeType);
      return jsonDecode(value.body);
    });
    print(res.runtimeType);
    return res;
  }
}
