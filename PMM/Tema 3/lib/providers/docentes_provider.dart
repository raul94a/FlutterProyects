import 'dart:convert';
import 'package:exament3/models/docentes_model.dart';
import 'package:http/http.dart' as http;

class DocentesProvider {
  static Uri uri = Uri.parse(
      'https://examen-t3-2021-default-rtdb.firebaseio.com/docentes.json');
  static String endpoint =
      'https://examen-t3-2021-default-rtdb.firebaseio.com/docentes.json';

  static Future<dynamic> get() async =>
      await http.get(uri).then((value) => docenteResponseFromJson(value.body));
}

void main(List<String> args) async {
  print(await DocentesProvider.get());
}
