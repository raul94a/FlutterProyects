import 'package:flutter/material.dart';
class CardItemInformation extends StatelessWidget {
  const CardItemInformation({
    Key? key,
    required this.duration,
    required this.complexityText,
    required this.affordabilityText,
  }) : super(key: key);

  final int duration;
  final String complexityText;
  final String affordabilityText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
              ),
              SizedBox(width: 6),
              Text('$duration min'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.work),
              SizedBox(width: 6),
              Text('${complexityText}'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.attach_money),
              SizedBox(width: 6),
              Text('${affordabilityText}'),
            ],
          )
        ],
      ),
    );
  }
}