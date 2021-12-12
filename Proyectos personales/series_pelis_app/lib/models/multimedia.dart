class Multimedia {
  String? firebaseId;
  bool? serie;
  int? id;
  String? nombre;
  double? interes;
  bool? vista;
  List<String> comentarios = [];



  Multimedia(this.id, this.nombre, this.interes, this.comentarios, this.serie,
      {this.vista = false});

  Multimedia.fromJson(Map<String, dynamic> mapa, String firebase) {
    firebaseId = firebase;
    id = mapa['id'];
    // print(id);
    serie = mapa['serie'];
    // print(serie);
    nombre = mapa['nombre'];
    // print(nombre);
    interes = mapa['interes'];
    // print(interes);
    vista = mapa['vista'];
    // print(vista);
    comentarios = (mapa['comentarios'] as List<dynamic>)
        .map((e) => e['comentario'] as String)
        .toList();
    ;
  }

  Map<String, dynamic> toMap() => {
        "firebaseId": firebaseId,
        "id": id,
        "serie": serie,
        "nombre": nombre,
        "interes": interes,
        "vista": vista,
        "comentario": comentarios
      };

  //console
  @override
  String toString() {
    // TODO: implement toString
    return "Firebase: $firebaseId\nID: $id\nNombre: $nombre\nInteres: $interes\nVista: ${vista! ? 'Si' : 'No'}\nComentarios: $comentarios";
  }
}
