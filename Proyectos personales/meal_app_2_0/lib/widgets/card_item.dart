import 'package:flutter/material.dart';
import '../models/meal_model.dart';

import 'card_item_image.dart';
import 'card_item_info.dart';

class CardItem extends StatelessWidget {
  final Meal meal;
  CardItem(this.meal);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'meal-details', arguments: meal),
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [CardItemImage(meal), CardItemInfo(meal)],
        ),
      ),
    );
  }
}
