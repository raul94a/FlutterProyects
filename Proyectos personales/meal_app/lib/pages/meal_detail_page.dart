import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/services/meal_model.dart';
import 'package:meal_app/services/meals_provider.dart';
import 'package:provider/provider.dart';

class MealDetailPage extends StatelessWidget {
  Widget buildSectionText(context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.headline1),
    );
  }

  Widget buildContainer(Widget child, double height) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        height: height,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context)!.settings.arguments as String;
    final mealsData = Provider.of<MealsProvider>(context, listen: false);
    final selectedMeal =
        mealsData.meals.firstWhere((meal) => meal.id == mealId);
    print('revbuiled');
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/img/loading2.gif'),
                image: NetworkImage(selectedMeal.imageUrl!),
              ),
            ),
            buildSectionText(context, 'Ingredients'),
            buildContainer(
                ListView.builder(
                    itemCount: selectedMeal.ingredients.length,
                    itemBuilder: (_, index) {
                      return Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(selectedMeal.ingredients[index]),
                        ),
                      );
                    }),
                150),
            buildSectionText(context, 'steps'),
            buildContainer(
                ListView.builder(
                    itemCount: selectedMeal.steps.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${(index + 1)}'),
                            ),
                            title: Text(selectedMeal.steps[index]),
                          ),
                          Divider(
                            height: 4,
                            thickness: 2.2,
                          )
                        ],
                      );
                    }),
                300),
          ],
        ),
      ),
      //CON CONSUMER CONSEGUIMOS QUE NO SE REBUILDEE TODA LA PÁGINA
      floatingActionButton: Consumer<MealsProvider>(
        builder: (context, meals, child) => FloatingActionButton(
          child: Icon(
              meals.meals.firstWhere((element) => element.id == mealId).isFav
                  ? Icons.star
                  : Icons.star_border),
          onPressed: () {
            mealsData.toggleFavorite(mealId);
          },
        ),
      ),
    );
  }
}
