import 'package:flutter/material.dart';
import 'package:meal_app/models/meal_model.dart';

import 'card_item_image.dart';
import 'card_item_information.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function? removeItem;
  MealItem(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.duration,
      required this.complexity,
      required this.affordability,
      this.removeItem});

  String get complexityText {
    if (complexity == Complexity.Simple) {
      return 'Simple';
    } else if (complexity == Complexity.Challenging) {
      return 'Challenging';
    } else {
      return 'Hard';
    }
  }

  String get affordabilityText {
    if (affordability == Affordability.Pricey) {
      return 'Pricey';
    } else if (affordability == Affordability.Affordable) {
      return 'Affordable';
    } else {
      return 'Luxurious';
    }
  }

  @override
  void selectMeal(BuildContext context) {
    Navigator.pushNamed(context, 'category/meals/detail', arguments: id)
        .then((value) {
      if (value != null) {
        //removeItem(value);
      }
    });
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        // clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            CardItemImage(imageUrl: imageUrl, title: title),
            CardItemInformation(
                duration: duration,
                complexityText: complexityText,
                affordabilityText: affordabilityText)
          ],
        ),
      ),
    );
  }
}
