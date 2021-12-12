import 'package:flutter/material.dart';
import 'package:meal_app/models/meal_model.dart';
import 'package:meal_app/widgets/meal_item.dart';

class FavoritesPage extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesPage(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('No items yet'),
      );
    } else {
      return Scaffold(body: ListView.builder(
                itemCount: (favoriteMeals).length,
                itemBuilder: (_, index) {
                  return MealItem(
                    //  removeItem: _removeItem,
                      id: favoriteMeals[index].id!,
                      title: favoriteMeals[index].title!,
                      imageUrl: favoriteMeals[index].imageUrl!,
                      duration: favoriteMeals[index].duration,
                      complexity: favoriteMeals[index].complexity,
                      affordability: favoriteMeals[index].affordability);
                }));
    }
  }
}
