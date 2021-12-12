import 'dart:convert';

import 'package:http/http.dart' as http;

class RoutesProvider {
  static Uri uri = Uri.parse(
      'https://examen-t3-2021-default-rtdb.firebaseio.com/rutas.json');
  static String endpoint =
      'https://examen-t3-2021-default-rtdb.firebaseio.com/rutas';

  static Future<List<Map<String, dynamic>>> get() async {
    http.Response response = await http.get(uri);

    // print(jsonDecode(response.body));
    List<dynamic> routesFromFirebase = jsonDecode(response.body);

    List<Map<String, dynamic>> routes = [];
    routesFromFirebase.forEach((element) {
      if (element['active'] == true) {
        routes.add(element);
      }
    });
    // print(routes);
    // routesFromFirebase.forEach((key, value) {
    //   if (value['active']) routes.add(value);
    // });

    return routes;
  }
}

// void main(List<String> args) async {
//   await RoutesProvider.get().then((value) => print(value));
// }
