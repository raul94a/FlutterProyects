import 'dart:convert';
import 'dart:ffi';

import 'package:examen_t4/models/jugador_model.dart';
import 'package:http/http.dart' as http;

class FutbolService {
  static Uri uriEquipos =
      Uri.parse('http://api.football-data.org/v2/competitions/2014/teams');
  static String uriJugadoresEquipo = 'http://api.football-data.org/v2/teams/';

  static String apiKey = 'e76328cff75541f189be9d20e9296c53';
  //funciona
  static Future<dynamic> getEquipos() async {
    final res = await http.get(uriEquipos, headers: {
      "X-Auth-token": apiKey
    }).then((value) => jsonDecode(value.body));

    List<dynamic> equipos = [];
    (res as Map).forEach((key, value) {
      if (key == 'teams') {
        (value as List).forEach((element) {
          equipos.add({"id": element['id'], "nombre": element['name']});
        });
      }
    });
    return equipos;
  }

  static Future<dynamic> getJugadoresEquipo(int id) async {
    Uri uriJugadores = Uri.parse('http://api.football-data.org/v2/teams/$id');
    final res = await http.get(uriJugadores, headers: {
      'X-Auth-Token': apiKey
    }).then((value) => jsonDecode(value.body));
    List<dynamic> squad = (res as Map)['squad'];
    List<Jugador> jugadores = [];
    squad.forEach((element) {
      jugadores.add(Jugador.fromMap(element));
    });
    return jugadores;
  }
}
