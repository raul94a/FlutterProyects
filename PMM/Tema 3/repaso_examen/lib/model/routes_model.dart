class Routes {
  String? firebaseId;
  String? route;

  Routes(this.firebaseId, this.route);
  Routes.fromJson(Map<String, dynamic> mapa, String id) {
    firebaseId = id;
    route = mapa['ruta'];
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'Ruta: $route';
  }
}
