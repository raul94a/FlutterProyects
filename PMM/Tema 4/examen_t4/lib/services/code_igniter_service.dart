import 'dart:convert';
import 'package:examen_t4/models/jugador_model.dart';
import 'package:http/http.dart' as http;

class CodeIgniterService {
  static Uri uriJugadores = Uri.parse(
      'https://carlosprofe.synology.me/apiraul_v1/index.php/jugadores/jugadores');
  static String uriJugador =
      'https://carlosprofe.synology.me/apiraul_v1/index.php/jugadores/jugador/';
  static Future<dynamic> getJugador(int id) async {
    final res = await http
        .get(Uri.parse('$uriJugador$id'))
        .then((value) => jsonDecode(value.body));

    return Jugador.fromMapCodeigniter(res as Map<String, dynamic>);
  }

  static Future<dynamic> get() async {
    final res =
        await http.get(uriJugadores).then((value) => jsonDecode(value.body));

    List<Jugador> jugadores = [];
    (res as List).forEach((element) {
      jugadores.add(Jugador.fromMapCodeigniter(element));
    });
    return jugadores;
  }

  static Future<void> post(Jugador jugador) async =>
      await http.post(Uri.parse(uriJugador),
          headers: {
            "content-type": "application/json",
            'Accept': 'application/json',
          },
          body: jsonEncode(jugador));

  static Future<void> put(Jugador jugador) async =>
      await http.put(Uri.parse(uriJugador),
          headers: {
            "content-type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(jugador));

  static Future<void> delete(int id) async {
    await http.delete(
        Uri.parse(
            'https://carlosprofe.synology.me/apiraul_v1/index.php/jugadores/jugador/$id'),
        headers: {
          "content-type": "application/json",
          'Accept': 'application/json',
        });
    return;
  }
}
