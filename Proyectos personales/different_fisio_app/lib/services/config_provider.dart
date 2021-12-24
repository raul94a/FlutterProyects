import 'dart:convert';

import 'package:http/http.dart' as http;

class ConfigProvider {
  static Uri uri = Uri.parse(
      'https://differentfisioapi-default-rtdb.europe-west1.firebasedatabase.app/navigation.json');
  static String endpoint =
      'https://differentfisioapi-default-rtdb.europe-west1.firebasedatabase.app/navigation';

  static Uri mysql =
      Uri.parse('http://192.168.1.115/restful/index.php/rutas/rutas');

  static Future<dynamic> get() async {
    final Map<String, dynamic> res =
        await http.get(uri).then((value) => jsonDecode(value.body));
    List<Map<String, dynamic>> config = [];
    //extraemos la data
    res.forEach((key, value) {
      if (value['activo'] == true) {
        config.add(value);
      }
    });

    return config;
  }

  static Future<dynamic> getFromMysql() async {
    final List<dynamic> res =
        await http.get(mysql).then((value) => jsonDecode(value.body));

    return res;
  }
}
