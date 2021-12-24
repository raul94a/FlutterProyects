import 'package:flutter/material.dart';

class FiltersPage extends StatefulWidget {
  Map<String, bool> filters;
  Function setMeals;
  FiltersPage(this.filters, this.setMeals);
  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  bool _btnPressed = false;

  void _changeBtnColorAfterPressed(int duration) {
    setState(() {
      _btnPressed = true;
    });
    Future.delayed(Duration(milliseconds: duration)).then((value) {
      setState(() {
        _btnPressed = false;
      });
    });
  }

  void initState() {
    super.initState();
    _glutenFree = widget.filters['gluten']!;
    _lactoseFree = widget.filters['lactose']!;
    _vegetarian = widget.filters['vegetarian']!;
    _vegan = widget.filters['vegan']!;
  }

  void _setGluten() => setState(() {
        _glutenFree = _glutenFree ? false : true;
        widget.filters['gluten'] = _glutenFree;
      });
  void _setLactose() => setState(() {
        _lactoseFree = _lactoseFree ? false : true;
        widget.filters['lactose'] = _lactoseFree;
      });
  void _setVegetarian() => setState(() {
        _vegetarian = _vegetarian ? false : true;
        widget.filters['vegetarian'] = _vegetarian;
      });
  void _setVegan() => setState(() {
        _vegan = _vegan ? false : true;
        widget.filters['vegan'] = _vegan;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configuración - Filtrado'),
          backgroundColor: Color.fromRGBO(106, 103, 158, 1),
          actions: [
            IconButton(
                onPressed: () async {
                  final filters = {
                    'gluten': _glutenFree,
                    'lactose': _lactoseFree,
                    'vegetarian': _vegetarian,
                    'vegan': _vegan
                  };
                  widget.setMeals();
                  _changeBtnColorAfterPressed(350);
                },
                icon: Icon(
                  Icons.save,
                  color: _btnPressed
                      ? Color.fromRGBO(220, 225, 255, 01)
                      : Colors.white,
                ))
          ],
        ),
        body: Column(children: [
          _buildSwitch('Gluten', 'Restringir o permitir recetas con gluten',
              _glutenFree, _setGluten),
          _buildSwitch('Lactosa', 'Restringir o permitir recetas con lactosa',
              _lactoseFree, _setLactose),
          _buildSwitch(
              'Vegetariano',
              'Restringir búsqueda por recetas vegetarianas',
              _vegetarian,
              _setVegetarian),
          _buildSwitch('Vegano', 'Restringir búsqueda por recetas veganas',
              _vegan, _setVegan),
          SizedBox(
            height: 20,
          ),
        ]));
  }

  Widget _buildSwitch(
      String text, String subtitle, bool option, Function setter) {
    return SwitchListTile(
        title: Text(text),
        subtitle: Text(subtitle),
        value: option,
        onChanged: (value) => setter());
  }
}
