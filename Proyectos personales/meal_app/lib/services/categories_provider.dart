import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/services/category_model.dart' as cat;

class CategoriesProvider with ChangeNotifier {
  final List<cat.Category> _DUMMY_CATEGORIES = [
    cat.Category(
      id: 'c1',
      title: 'Italian',
      color: Colors.purple,
    ),
    cat.Category(
      id: 'c2',
      title: 'Quick & Easy',
      color: Colors.red,
    ),
    cat.Category(
      id: 'c3',
      title: 'Hamburgers',
      color: Colors.orange,
    ),
    cat.Category(
      id: 'c4',
      title: 'German',
      color: Colors.amber,
    ),
    cat.Category(
      id: 'c5',
      title: 'Light & Lovely',
      color: Colors.blue,
    ),
    cat.Category(
      id: 'c6',
      title: 'Exotic',
      color: Colors.green,
    ),
    cat.Category(
      id: 'c7',
      title: 'Breakfast',
      color: Colors.lightBlue,
    ),
    cat.Category(
      id: 'c8',
      title: 'Asian',
      color: Colors.lightGreen,
    ),
    cat.Category(
      id: 'c9',
      title: 'French',
      color: Colors.pink,
    ),
    cat.Category(
      id: 'c10',
      title: 'Summer',
      color: Colors.teal,
    ),
  ];

  List<cat.Category> get categories => [..._DUMMY_CATEGORIES];
}
