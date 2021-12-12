import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/models/meal_model.dart';
import 'package:meal_app/pages/categories_page.dart';
import 'package:meal_app/pages/filters_page.dart';
import 'package:meal_app/pages/login_page.dart';
import 'package:meal_app/pages/splash_page.dart';

import 'pages/category_meal_page.dart';
import 'pages/meal_details_page.dart';
import 'pages/tab_page.dart';

/*

HACER EL DRAWER
PAGINAS DE FILTROS
LOGICA DE FILTRADO!


*/

void main() {
  runApp(const MyApp());
}

//REHACER LA APP CON LA LÓGICA DEL PROVIDER
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //IDEA ESTO LO PUEDO COGER DE MEMORIA DEL DISPOSITIVO

  final Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegetarian": false,
    "vegan": false
  };

  List<Meal> _availableMeals = [];
  List<Meal> _favorites = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setAvailableMeals();
  }

  bool _isMealFavorite(String mealId) {
    for (var fav in _favorites) {
      if (fav.id == mealId) return true;
    }
    return false;
  }

  void _toggleFavorite(String mealId) {
    if (_isMealFavorite(mealId)) {
      final meal = _favorites.firstWhere((element) => element.id == mealId);
      setState(() {
        _favorites.remove(meal);
      });
      return;
    }
    Meal meal = _availableMeals.firstWhere((element) => element.id == mealId);
    setState(() {
      _favorites.add(meal);
    });
  }

  void _setAvailableMeals() {
    setState(() {
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] as bool && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: 'splash',
      routes: {
        "login": (context) => LoginPage(),
        "splash": (context) => SplashPage(),
        "categories": (context) => CategoriesPage(),
        "tab": (context) => TabPage(_favorites),
        "category/meals": (context) => CategoryMeal(_availableMeals),
        "meal-details": (context) =>
            MealDetailPage(_isMealFavorite, _toggleFavorite),
        "filters": (context) => FiltersPage(_filters, _setAvailableMeals),
      },
      theme: ThemeProvider.themeData(),
      home: TabPage(_favorites),
    );
  }
}

class ThemeProvider {
  static ThemeData themeData() {
    return ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline1: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed',
            )));
  }
}
