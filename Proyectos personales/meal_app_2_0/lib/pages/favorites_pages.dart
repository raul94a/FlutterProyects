import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../widgets/card_item.dart';

class FavoritesPage extends StatelessWidget {
  final List<Meal> favorites;
  FavoritesPage(this.favorites);
  @override
  Widget build(BuildContext context) {
    return favorites.isEmpty
        ? const Center(
            child: Text(
              'No hay favoritos aun',
              style: TextStyle(
                  letterSpacing: 1.4,
                  fontSize: 28,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
          )
        : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (_, index) {
              return CardItem(favorites[index]);
            });
  }
}
