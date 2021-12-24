import 'package:flutter/material.dart';
import 'package:meal_app/services/meal_model.dart';
import 'package:meal_app/services/meals_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';

class CategoryMealPage extends StatelessWidget {
  // final List<Meal> _availableMeals;
  // CategoryMealPage(this._availableMeals);

  // String categoryTitle = '';
  // List<Meal> meals = [];
  //por qué esté bool es necesario?

  /*
  Simplemente porque cuando declaramos el didChangeDependencies, necesitamos que le codigo dentro de la función se ejecute solo cuando está
  a false. En caso contrario la función de borrar item no funcionaría, pues es llamada antes que este método, el cual
  sobreescribiría cualquier acción realizada sobre el arbol de widgets.

  */
  //bool loadedInitialData = false;

  // //INIT STATE SE CARGA ANTES DE QUE CONTEXT ESTÉ DISPONIBLE, DE TAL FORMA QUE ESTO DA ERROR...LA UNICA SOLUCION
  // //QUE LE VEO ES USAR ESTE ESTADO PARA CARGAR LOS ARGS Y REALIZAR LAS OPERACIONES NECESARIAS
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   if (!loadedInitialData) {
  //     final Map<String, dynamic> args =
  //         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  //     categoryTitle = args['title'];
  //     final categoryId = args['id'];
  //     meals = widget._availableMeals
  //         .where((meal) => meal.categories.contains(args['id']))
  //         .toList();
  //     loadedInitialData = true;
  //   }
  // }

  // void _removeItem(String mealId) {
  //   setState(() {
  //     meals.removeWhere((element) => element.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final List<Meal> meals =
        Provider.of<MealsProvider>(context).availableMeals(args['id']);
    // final categoryMeals = DUMMY_MEALS
    //     .where((meal) => meal.categories.contains(args['id']))
    //     .toList();

    // print(args);
    return Scaffold(
        appBar: AppBar(title: Text(args['title'])),
        body: !meals.isEmpty
            ? ListView.builder(
                itemCount: (meals).length,
                itemBuilder: (_, index) {
                  return MealItem(
                      //removeItem: _removeItem,
                      id: meals[index].id!,
                      title: meals[index].title!,
                      imageUrl: meals[index].imageUrl!,
                      duration: meals[index].duration,
                      complexity: meals[index].complexity,
                      affordability: meals[index].affordability);
                })
            : const Center(
                child: Text(
                  'No hay recetas disponibles',
                  style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ));
  }
}
