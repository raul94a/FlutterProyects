import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repaso_examen_ii/config/config.dart';

class ColoresProvider {
  static Uri uri = Uri.parse(
      /*'http://$ipCasa/restful/index.php/colores/colores'*/ 'https://carlosprofe.synology.me/pedro_rest/index.php/colores/colores');

  static Future<dynamic> get() async {
    final List<dynamic> res =
        await http.get(uri).then((value) => jsonDecode(value.body));

    bool existsActive() {
      bool active = false;
      res.forEach((element) {
        if (element['activo'] == '1') active = true;
      });
      return active;
    }

    Map<String, dynamic>? colorActivo = {};

    if (existsActive()) {
      colorActivo = res.firstWhere((element) => element['activo'] == '1');
      print(colorActivo);
      return colorActivo!['color'];
    }

    return 'azul';
  }
}
