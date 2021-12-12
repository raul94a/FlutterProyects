import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FotosProvider {
  static Uri uri =
      Uri.parse('https://api.pexels.com/v1/search?query=school&per_page=10');
  static String endpoint =
      'https://api.pexels.com/v1/search?query=school&per_page=10';

  static Future<dynamic> get() async {
    return await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          '563492ad6f91700001000001ef8d06dfea6b465ca5afd0e987102827'
    }).then((value) {
      //print(value.body);
      return jsonDecode(value.body)['photos'];
    });
  }
}

void main(List<String> args) async {
  print(await FotosProvider.get());
}
