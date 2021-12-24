import 'package:flutter/material.dart';
import 'package:meal_app/services/meals_provider.dart';
import 'package:provider/provider.dart';

class FiltersPage extends StatelessWidget {
  @override
  // final Function saveFilters;
  // final Map<String, bool> currentFilters;
//   FiltersPage(this.currentFilters, this.saveFilters);
//   _FiltersPageState createState() => _FiltersPageState();
// }

// class _FiltersPageState extends State<FiltersPage> {
//   bool _glutenFree = false;
//   bool _lactoseFree = false;
//   bool _vegetarian = false;
//   bool _vegan = false;

//   //las opciones son glutenfree, lactosefree...
//   void _setGlutenFreeValue(value) => setState(() => _glutenFree = value);
//   void _setLactoseFreeValue(value) => setState(() => _lactoseFree = value);
//   void _setVegetarianValue(value) => setState(() => _vegetarian = value);
//   void _setVeganValue(value) => setState(() => _vegan = value);

//   void initState() {
//     super.initState();
//     _glutenFree = widget.currentFilters['gluten'] as bool;
//     _lactoseFree = widget.currentFilters['lactose'] as bool;
//     _vegetarian = widget.currentFilters['vegetarian'] as bool;
//     _vegan = widget.currentFilters['vegan'] as bool;
//   }

  Widget _buildSwithListTile(
      String title, String description, bool currentValue, updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: currentValue,
        onChanged: (value) {
          updateValue(value);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mealsData = Provider.of<MealsProvider>(context);
    Map<String, bool> mealsFilters = mealsData.filters;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  // final filters = {
                  //   'gluten': _glutenFree,
                  //   'lactose': _lactoseFree,
                  //   'vegetarian': _vegetarian,
                  //   'vegan': _vegan
                  // };
                  // widget.saveFilters(filters);
                },
                icon: Icon(Icons.save))
          ],
          centerTitle: true,
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pushReplacementNamed(context, 'tab'),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text('Filters')
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Adjust your meal selection.',
                  style: Theme.of(context).textTheme.headline1),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwithListTile(
                    'Gluten-free',
                    'Only include gluten-free meals',
                    mealsFilters['gluten'] as bool,
                    mealsData.gluten),
                _buildSwithListTile(
                    'Lactose-free',
                    'Only include lactose-free meals',
                    mealsFilters['lactose'] as bool,
                    mealsData.lactose),
                _buildSwithListTile(
                    'Vegetarian',
                    'Only include vegetarian meals',
                    mealsFilters['vegetarian'] as bool,
                    mealsData.vegetarian),
                _buildSwithListTile('Vegan', 'Only include Vegan meals',
                    mealsFilters['vegan'] as bool, mealsData.vegan),
              ],
            ))
          ],
        ));
  }
}
