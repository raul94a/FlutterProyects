import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:series_pelis_app/models/multimedia.dart';

class MultimediaProvider {
  static Uri uri = Uri.parse(
      'https://pelis-y-series-3ee2d-default-rtdb.europe-west1.firebasedatabase.app/multimedia.json');
  static String endpoint =
      'https://pelis-y-series-3ee2d-default-rtdb.europe-west1.firebasedatabase.app/multimedia';

  static Future<List<Multimedia>> getAll() async {
    List<Multimedia> multimedia = [];
    final res = await http.get(uri).then((value) => jsonDecode(value.body));
    (res as Map).forEach((key, value) {
      multimedia.add(Multimedia.fromJson(value, key));
    }); //multimedia.add(Multimedia.fromJson(value, key)));
    return multimedia;
  }
}


