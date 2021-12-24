class Jugador {
  int? id;
  String? nombre;
  String? posicion;
  String? fechaNacimiento;
  String? paisNacimiento;
  String? nacionalidad;
  String? rol;
  bool? favorito = false;
  String? comentario = 'Sin comentario added';

  Jugador(
      {required this.id,
      required this.nombre,
      required this.posicion,
      required this.fechaNacimiento,
      required this.paisNacimiento,
      required this.nacionalidad,
      required this.rol});
  Jugador.fromMap(Map<String, dynamic> mapa) {
    id = mapa['id'];
    nombre = mapa['name'];
    posicion = mapa['position'] ?? "desconocido";
    fechaNacimiento = mapa['dateOfBirth'] ?? "no se sabe cuando nació";
    paisNacimiento = mapa['countryOfBirth'] ?? "no se sabe donde nació";
    nacionalidad = mapa['nationality'] ?? "desconocida";
    rol = mapa['role'] ?? "desconocido";
    favorito = mapa['favorito'] == null ? false : mapa['favorito'];
  }
  Jugador.fromMapCodeigniter(Map<String, dynamic> mapa) {
    id = mapa['id'];
    nombre = mapa['nombre'];
    posicion = mapa['posicion'];
    fechaNacimiento = mapa['fechaNacimiento'];
    paisNacimiento = mapa['paisNacimiento'];
    nacionalidad = mapa['nacionalidad'];
    rol = mapa['rol'];
    favorito = id != null ? true : false;
    comentario = mapa['comentario'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "posicion": posicion,
        "fechaNacimiento": fechaNacimiento,
        "paisNacimiento": paisNacimiento,
        "nacionalidad": nacionalidad,
        "rol": rol,
        "comentario": comentario
      };
  @override
  String toString() {
    // TODO: implement toString
    return "\nDatos del jugador:\n\tNombre: $nombre\nPosicion: $posicion\nFavorito: $favorito";
  }
}
