import 'package:flutter/material.dart';
import 'package:meal_app/models/meal_model.dart';
import 'package:meal_app/widgets/category_item.dart';
import 'package:meal_app/dummy_data.dart';

class CategoriesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Categories - Meal'),
      // ),
      //Utilizar GridView
      /*  necesita el gridDelegate, que recibe un constructor de tipo
        SliverGridDelegateWithMaxCrossAxisExtent, dentro del cual se declara
        maxCroxxAxisExtent => tamaño del contenedor renderizado
        mainAxisSpacing => espaciado entre contenedores
        childAspectRatrion => define la relacion entre WIDTH / HEIGHT
            ejemplo: si ponemos 1 / 2 crearemos tres partes de las cuales
                    una seran para el ancho y dos para la altura (mas alto que ancho)
        crossAxisSPACING : espaciado en el eje contrario al de pintar
        
        además, dentro de gridView se puede declarar la direccion de scroll

      */
      body: GridView(
        //scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 20,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20),
        children: [
          ...DUMMY_CATEGORIES
              .map((e) => CategoryItem(e.id!, e.title!, e.color))
              .toList()
        ],
      ),
    );
  }
}
