import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../widgets/drawer.dart';
import 'categories_page.dart';
import 'favorites_pages.dart';

class TabPage extends StatefulWidget {
  final favorites;
  TabPage(this.favorites);
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<Widget> _pages = [];

  List<Meal> _favs = [];
  int _selectedPage = 0;

  void _selectedPageHandler(int index) {
    setState(() {
      _selectedPage = index;
      title = titles[index]!;
    });
  }

  String title = 'Categorías';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favs = widget.favorites;
    _pages = [CategoriesPage(), FavoritesPage(widget.favorites)];
  }

  Map<int, String> titles = {0: "Categorías", 1: "Favoritos"};
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Color.fromRGBO(106, 103, 158, 1),
        ),
        body: _pages[_selectedPage],
        drawer: CustomDrawer(),
        bottomNavigationBar: _buildNavigation());
  }

  BottomNavigationBar _buildNavigation() {
    return BottomNavigationBar(
        elevation: 20,
        currentIndex: _selectedPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.amber,
        selectedIconTheme: IconThemeData(color: Colors.amber),
        selectedFontSize: 14,
        unselectedItemColor: Colors.white,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        unselectedFontSize: 11,
        onTap: _selectedPageHandler,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
                //color: Colors.black54,
              ),
              title: Text(
                'Categorias',
                //style: TextStyle(color: Colors.black54),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                //color: Colors.black54,
              ),
              title: Text(
                'Favoritos',
                // style: TextStyle(color: Colors.black54),
              ))
        ]);
  }
}
