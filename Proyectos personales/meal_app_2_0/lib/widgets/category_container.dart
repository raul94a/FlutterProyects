import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryContainer(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () =>
          Navigator.pushNamed(context, 'category/meals', arguments: id),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(title, style: Theme.of(context).textTheme.headline1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
      ),
    );
  }
}
