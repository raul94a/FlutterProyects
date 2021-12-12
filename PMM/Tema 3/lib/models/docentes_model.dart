// To parse this JSON data, do
//
//     final docenteResponse = docenteResponseFromJson(jsonString);

import 'dart:convert';

List<DocenteResponse> docenteResponseFromJson(String str) =>
    List<DocenteResponse>.from(
        json.decode(str).map((x) => DocenteResponse.fromJson(x)));

String docenteResponseToJson(List<DocenteResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DocenteResponse {
  DocenteResponse({
    this.email,
    this.name,
    this.photo,
    this.rol,
    this.subname,
  });

  String? email;
  String? name;
  String? photo;
  String? rol;
  String? subname;

  factory DocenteResponse.fromJson(Map<String, dynamic> json) =>
      DocenteResponse(
        email: json["email"],
        name: json["name"],
        photo: json["photo"],
        rol: json["rol"],
        subname: json["subname"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "photo": photo,
        "rol": rol,
        "subname": subname,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "nombre:$name\nEmail: $email\nrol: $rol\nsubname:$subname";
  }
}
