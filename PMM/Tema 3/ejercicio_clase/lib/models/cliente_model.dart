class Cliente {
  String? id;
  String? nombre;
  String? activo;
  String? correo;
  String? zip;
  String? telefono1;
  String? telefono2;
  String? pais;
  String? direccion;

  Cliente(this.id, this.nombre, this.activo, this.correo, this.zip,
      this.telefono1, this.telefono2, this.pais, this.direccion);
  Cliente.fromJson(Map<String, dynamic> mapa) {
    // print(mapa['id']);
    //  print(mapa['nombre']);
    //   print(mapa['activo']);
    //   print(mapa['correo']);
    //   print(mapa['direccion']);
    //   print(mapa['telefono1']);
    //   print(mapa['telefono2']);
    //   print(mapa['zip']);
    //   print(mapa['pais']);
    id = mapa['id'];
    
    nombre = mapa['nombre'];
   
    activo = mapa['activo'];
    correo = mapa['correo'];
    zip = mapa['zip'];
    telefono1 = mapa['telefono1'];
    telefono2 = mapa['telefono2'];
    pais = mapa['pais'];
    direccion = mapa['direccion'];
  }

  Map<String, dynamic> toJson() => {
       // "id": id,
        "nombre": nombre,
        "pais": pais,
        "activo": activo,
        "correo": correo,
        "zip": zip,
        "telefono1": telefono1,
        "telefono2": telefono2,
        "direccion": direccion
      };
}
