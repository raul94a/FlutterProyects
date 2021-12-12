class Product {
  String? firebaseId;
  String? nombre;
  double? precio;
  String? descripcion;
  String? avatar;

  Product(
      this.firebaseId, this.nombre, this.precio, this.descripcion, this.avatar);

  Product.fromJson(Map<String, dynamic> mapa, String id) {
    firebaseId = id;
    nombre = mapa['nombre'];
    precio = mapa['precio'];
    descripcion = mapa['descripcion'];
    avatar = mapa['avatar'];
  }

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "precio": precio,
        "descripcion": descripcion,
        "avatar": avatar
      };
  @override
  String toString() {
    // TODO: implement toString
    return 
      "\nid: $firebaseId\nNombre:$nombre\nPrecio;$precio\nDescripcion:$descripcion\nurl$avatar"
    ;
  }
}
