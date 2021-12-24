import 'package:flutter/material.dart';
import 'package:meal_app/services/meal_model.dart';
import 'package:meal_app/services/meals_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Meal> favoriteMeals =
        Provider.of<MealsProvider>(context).favoriteMeals;
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('No items yet'),
      );
    } else {
      return Scaffold(
          body: ListView.builder(
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
