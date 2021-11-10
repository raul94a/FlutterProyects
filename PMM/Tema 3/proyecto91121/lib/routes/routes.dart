import 'package:flutter/cupertino.dart';
import '../pages/CardPage.dart';
import '../pages/alert.dart';
import '../pages/avatar.dart';
import '../pages/home_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return {
    'home': (BuildContext context) => HomePage(),
    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
  };
}
