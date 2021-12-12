import 'package:flutter/material.dart';
import '../models/meal_model.dart';

class CardItemImage extends StatelessWidget {
  final Meal meal;
  CardItemImage(this.meal);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: FadeInImage(
              height: 250,
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/img/loading2.gif'),
              image: NetworkImage(
                meal.imageUrl!,
              ),
            )),
        Positioned(
          bottom: 20,
          right: 0,
          child: Container(
            width: 300,
            color: Colors.black54,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text(meal.title!,
                style: TextStyle(color: Colors.white, fontSize: 26),
                softWrap: true,
                overflow: TextOverflow.fade),
          ),
        ),
      ],
    );
  }
}
