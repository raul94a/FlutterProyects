import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
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

  void toggleFavouriteStatus() {
    fav = !fav;
    notifyListeners();
  }
}
