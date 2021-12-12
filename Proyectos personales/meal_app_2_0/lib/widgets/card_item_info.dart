import 'package:flutter/material.dart';
import '../models/meal_model.dart';
class CardItemInfo extends StatelessWidget {
  final Meal meal;
  CardItemInfo(this.meal);

  @override
  Widget build(BuildContext context) {
    String affordability(Meal meal) {
      if (meal.affordability == Affordability.Pricey) {
        return 'barato';
      } else if (meal.affordability == Affordability.Affordable) {
        return 'permisivo';
      } else
        return 'lujoso';
    }

    String complexity(Meal meal) {
      if (meal.complexity == Complexity.Simple) {
        return 'simple';
      } else if (meal.complexity == Complexity.Hard) {
        return 'difícil';
      } else
        return 'complicado';
    }

    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.timer),
              SizedBox(
                width: 15,
              ),
              Text(meal.duration.toString() + ' min')
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.work),
              SizedBox(
                width: 15,
              ),
              Text(complexity(meal))
            ],
          ),
          Row(
            children: [
              Icon(Icons.price_change_rounded),
              SizedBox(
                width: 15,
              ),
              Text(affordability(meal))
            ],
          )
        ],
      ),
    );
  }
}
