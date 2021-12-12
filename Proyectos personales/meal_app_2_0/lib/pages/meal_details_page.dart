import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../widgets/card_item_image.dart';

class MealDetailPage extends StatefulWidget {
  final Function(String) isMealFavorite;
  final Function(String) toggleMeal;
  MealDetailPage(this.isMealFavorite, this.toggleMeal);

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  Widget _buildText(String text) => Center(child: Text(text));
  Widget _buildContainer(Meal meal, Widget listViewBuilder) {
    return Container(
        padding: EdgeInsets.all(8),
        width: 320,
        height: 220,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: listViewBuilder);
  }

  Column _buildColumn(Meal meal, BuildContext context) {
    return Column(
      children: [
        CardItemImage(meal),
        const SizedBox(
          height: 20,
        ),
        _buildText('Ingredientes'),
        SizedBox(
          height: 20,
        ),
        _buildContainer(
          meal,
          ListView.builder(
              itemCount: meal.ingredients.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(8),
                  color: Colors.amber,
                  child: Text(meal.ingredients[index]),
                );
              }),
        ),
        _buildText('Pasos'),
        const SizedBox(
          height: 20,
        ),
        _buildContainer(
          meal,
          ListView.builder(
              itemCount: meal.ingredients.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    ListTile(
                      tileColor: Theme.of(context).canvasColor,
                      leading: CircleAvatar(
                        child: Text('#${index + 1}'),
                        backgroundColor: Colors.pink,
                      ),
                      title: Text(
                        meal.ingredients[index],
                      ),
                      horizontalTitleGap: 5,
                    ),
                    Divider(
                      color: Colors.black,
                    )
                  ],
                );
              }),
        ),
      ],
    );
  }

  bool btnPressed = false;

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context)!.settings.arguments as Meal;
    return Scaffold(
        appBar: AppBar(title: Text(meal.title!)),
        body: SingleChildScrollView(
            child: Stack(
          children: [
            _buildColumn(meal, context),
            if (btnPressed) _InfoToggleFavorites(widget: widget, meal: meal)
          ],
        )),
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          onPressed: btnPressed
              ? null
              : () async {
                  widget.toggleMeal(meal.id!);
                  setState(() {
                    btnPressed = true;
                  });
                  await Future.delayed(Duration(milliseconds: 1000));
                  setState(() {
                    btnPressed = false;
                  });
                },
          child: Icon(
              widget.isMealFavorite(meal.id!) ? Icons.star : Icons.star_border),
        ));
  }
}

class _InfoToggleFavorites extends StatelessWidget {
  const _InfoToggleFavorites({
    Key? key,
    required this.widget,
    required this.meal,
  }) : super(key: key);

  final MealDetailPage widget;
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.black54),
      child: Center(
        child: Text(
          !widget.isMealFavorite(meal.id!)
              ? 'La receta ha sido eliminada de tu lista de favoritos'
              : 'La receta ha sido añadida a tu lista de favoritos',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
              fontStyle: FontStyle.italic),
        ),
      ),
    ));
  }
}
