import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: Column(
        children: [
          _DrawerHero(),
          SizedBox(
            height: 20,
          ),
          DrawerListTileBuilder('Meals', Icons.restaurant, () {
            Navigator.pushReplacementNamed(context, 'categories');
          }),
          DrawerListTileBuilder('Settings', Icons.settings,
              () => Navigator.pushReplacementNamed(context, 'filters')),
        ],
      ),
    );
  }
}

class DrawerListTileBuilder extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function tapHandler;
  DrawerListTileBuilder(this.title, this.icon, this.tapHandler);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: () => tapHandler(),
    );
  }
}

class _DrawerHero extends StatelessWidget {
  const _DrawerHero({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 220,
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/img/hero2.jpg'),
              fit: BoxFit.cover,
            )),
        Positioned(
          bottom: 20,
          right: 50,
          child: Container(
              width: 220,
              color: Colors.black54,
              child: Text('Your Meal App!',
                  style: TextStyle(fontSize: 25, color: Colors.white))),
        ),
      ],
    );
  }
}
