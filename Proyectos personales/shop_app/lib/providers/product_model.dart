import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool fav;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      @required this.fav = false});
  Product.fromMap(String firebaseId, Map<String, dynamic> map) {
    id = firebaseId;
    title = map['title'];
    description = map['description'];
    price = map['price'];
    imageUrl = map['imageUrl'];
    fav = false;
  }

  void toggleFavouriteStatus() {
    fav = !fav;
    notifyListeners();
  }
}
