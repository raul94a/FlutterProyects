import 'package:flutter/material.dart';
import 'package:meal_app/services/meal_model.dart';
import 'package:meal_app/pages/categories_page.dart';
import 'package:meal_app/widgets/app_drawer.dart';

import 'favorites_page.dart';

class TabPage extends StatefulWidget {
 
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<Map<String, dynamic>> _pages = [];
  int _selectedPageIndex = 0;

//necesito el init state porque widget es innnaccesible fuera del build, necesito el inistate

  void initState() {
    super.initState();
    _pages = [
      {"page": CategoriesPage(), "title": 'Categories'},
      {"page": FavoritesPage(), "title": 'Your Favourites'},
    ];
  }

  _changePage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: Text('Meals'),
    //         bottom: const TabBar(tabs: [
    //           Tab(
    //             icon: Icon(
    //               Icons.food_bank_rounded,
    //             ),
    //             text: 'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: 'Favorites',
    //           )
    //         ]),
    //       ),
    //       body: TabBarView(children: [
    //         CategoriesPage(),
    //         FavoritesPage(),
    //       ]),
    //     ));
    return Scaffold(
      appBar:
          AppBar(title: Text(_pages[_selectedPageIndex]['title'] as String)),
      body: _pages[_selectedPageIndex]['page'],
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changePage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
