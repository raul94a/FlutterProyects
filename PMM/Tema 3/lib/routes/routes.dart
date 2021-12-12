import 'package:exament3/pages/docentes_page.dart';
import 'package:exament3/pages/fotos_page.dart';
import 'package:exament3/pages/home_page.dart';
import 'package:exament3/pages/loca_page.dart';
import 'package:exament3/pages/login_page.dart';
import 'package:exament3/pages/oferta_page.dart';
import 'package:exament3/pages/splash_screen.dart';
import 'package:flutter/cupertino.dart';


Map<String, WidgetBuilder> applicationRoutes() =>
    {
      'home': (BuildContext context) => HomePage(),
      'login': (BuildContext context) => LoginPage(),
      "oferta_page": (BuildContext context) => OfertaPage(),
      "docentes_page": (BuildContext context) => DocentesPage(),
      "splash": (BuildContext context) => SplashPage(),
      "loca_page": (BuildContext context) => LocaPage(),
      "fotos_page": (BuildContext context) => FotosPage(),
      
    };
