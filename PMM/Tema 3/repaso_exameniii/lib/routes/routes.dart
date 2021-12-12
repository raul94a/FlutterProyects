import 'package:flutter/cupertino.dart';
import 'package:repaso_exameniii/pages/alert.dart';
import 'package:repaso_exameniii/pages/avatar.dart';
import 'package:repaso_exameniii/pages/card.dart';
import 'package:repaso_exameniii/pages/contenedor.dart';
import 'package:repaso_exameniii/pages/home_page.dart';
import 'package:repaso_exameniii/pages/inputs.dart';
import 'package:repaso_exameniii/pages/slider.dart';
import 'package:repaso_exameniii/pages/splash.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return {
    'splash': (BuildContext context) => SplashPage(),
    'home': (BuildContext context) => HomePage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'container': (BuildContext context) => ContainerPage(),
    'inputs': (BuildContext context) => InputsPage(),
    'slider': (BuildContext context) => SliderPage(),
  };
}
