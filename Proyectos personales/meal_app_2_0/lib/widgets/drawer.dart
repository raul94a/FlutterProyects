import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   

    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/img/macrofit-meals.jpg'),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
              ),
              _buildStackText('RecetApp', 70, 100, 0, 34),
              _buildStackText('Vamos a cocinar!', 180, 50, 0, 28),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          _buildListTile(Icons.restaurant, 'Categorías', 'categories', context),
          _buildListTile(Icons.settings, 'Configuración', 'filters', context),
          _buildGoogleMapsIntegration(context)
        ],
      ),
    );
  }

  Widget _buildListTile(
      IconData icon, String text, String route, BuildContext context) {
    return InkWell(
      onTap: () {
        if (route == 'categories') {
          Navigator.pushNamed(context, route, arguments: true);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(
          text,
          style: const TextStyle(
              fontSize: 22,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildGoogleMapsIntegration(context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'maps');
      },
      child: const ListTile(
        leading: Icon(Icons.map, size: 40),
        title: Text(
          'Acceder a Google Maps',
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStackText(
      String text, double top, double right, double left, double fontSize) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      child: Container(
        decoration: BoxDecoration(color: Colors.black54),
        height: 70,
        child: Center(
          child: Text(text,
              style: TextStyle(
                  letterSpacing: 1.2,
                  color: Colors.amber,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway-Regular')),
        ),
      ),
    );
  }
}
