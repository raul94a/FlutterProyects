import 'package:flutter/cupertino.dart';
import 'package:proyecto91121/pages/contenedor.dart';
import 'package:proyecto91121/pages/futbol.dart';
import 'package:proyecto91121/pages/infinito.dart';
import 'package:proyecto91121/pages/inputs.dart';
import 'package:proyecto91121/pages/slider_page.dart';
import 'package:proyecto91121/pages/splash.dart';
import '../pages/CardPage.dart';
import '../pages/alert.dart';
import '../pages/avatar.dart';
import '../pages/home_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return {
    'splash': (BuildContext context) => SplashPage(),
    'futbol': (BuildContext context) => FutbolPage(),
    'home': (BuildContext context) => HomePage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'container': (BuildContext context) => ContainerPage(),
    'inputs': (BuildContext context) => InputsPage(),
    "slider": (BuildContext context) => SliderPage(),
    "infinito": (BuildContext context) => Infinito()
  };
}
