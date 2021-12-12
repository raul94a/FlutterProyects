import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repaso_examen/model/routes_model.dart';

class RouterProvider {
  static Uri uri = Uri.parse(
      'https://repasot3-default-rtdb.europe-west1.firebasedatabase.app/rutas.json');
  static String endpoint =
      'https://repasot3-default-rtdb.europe-west1.firebasedatabase.app/rutas';

  static Future<List<String>> get() async {
    List<String> rutas = [];
    final response =
        await http.get(uri).then((value) => jsonDecode(value.body));
    response.forEach(
        (key, value) => {rutas.add(Routes.fromJson(value, key).route!)});
    return rutas;
  }
}

void main(List<String> args) {
  RouterProvider.get().then((value) => print(value));
}
