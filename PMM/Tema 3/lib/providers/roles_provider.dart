import 'dart:convert';

import 'package:http/http.dart' as http;


class RolesProvider{
  static Uri uri = Uri.parse('https://examen-t3-2021-default-rtdb.firebaseio.com/roles.json');
  static String endpoint = 'https://examen-t3-2021-default-rtdb.firebaseio.com/roles.json';

  static Future<dynamic> get() async => await http.get(uri).then((value) => jsonDecode(value.body));
}