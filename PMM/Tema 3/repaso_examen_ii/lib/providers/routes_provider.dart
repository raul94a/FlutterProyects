import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repaso_examen_ii/config/config.dart';

class RoutesProvider {
  static Uri uri = Uri.parse(
      'https://repasot3-default-rtdb.europe-west1.firebasedatabase.app/routes.json');
  static String endpoint =
      'https://repasot3-default-rtdb.europe-west1.firebasedatabase.app/routes';

  static Future<List<Map<String, dynamic>>> get() async {
    http.Response response = await http.get(uri);
    Map<String, dynamic> routesFromFirebase = jsonDecode(response.body);
    List<Map<String, dynamic>> routes = [];
    routesFromFirebase.forEach((key, value) {
      if (value['active']) routes.add(value);
    });

    return routes;
  }

  static Future<List<Map<String, dynamic>>> getFromMySQL() async {
    Uri url = Uri.parse(
        'https://carlosprofe.synology.me/pedro_rest/index.php/rutas/routes');
    final response =
        await http.get(url).then((value) => jsonDecode(value.body));
    print(response);
    List<Map<String, dynamic>> routes = [];
    response.forEach((value) {
      print(value);
      // print(value['tabBar'].runtimeType);
      if (value['activo'] == '1') routes.add(value);
    });
    return routes;
  }
}

void main(List<String> args) {
  RoutesProvider.get().then((value) => print(value));
}
