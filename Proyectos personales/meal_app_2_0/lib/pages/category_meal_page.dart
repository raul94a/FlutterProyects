import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';

import '../dummy_data.dart';
import '../widgets/card_item.dart';

class CategoryMeal extends StatelessWidget {
  final List<Meal> availableMeals;
  const CategoryMeal(this.availableMeals);

  @override
  Widget build(BuildContext context) {
    print(availableMeals);
    final String categoryId =
        ModalRoute.of(context)!.settings.arguments as String;

    final Category category =
        DUMMY_CATEGORIES.firstWhere((element) => element.id == categoryId);

    final List<Meal> meals = availableMeals
        .where((meal) => meal.categories.contains(categoryId))
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text('${category.title}'),
          backgroundColor: Color.fromRGBO(106, 103, 158, 1),
        ),
        body: meals.isEmpty
            ? const Center(
                child: Text('No hay recetas disponibles',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.bold)),
              )
            : ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  return CardItem(meals[index]);
                }));
  }
}
