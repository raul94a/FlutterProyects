import 'package:flutter/cupertino.dart';
import 'package:repaso_examen_ii/pages/add_product_page.dart';
import 'package:repaso_examen_ii/pages/product_page.dart';
import 'package:repaso_examen_ii/pages/products_page.dart';
import 'package:repaso_examen_ii/pages/splash_page.dart';
import 'package:repaso_examen_ii/pages/user_page.dart';
import 'package:repaso_examen_ii/pages/users_page.dart';

Map<String, WidgetBuilder> applicationRoutes(BuildContext context, fonts, titles) =>
    {
      "products": (BuildContext context) => ProductsPage(fonts,titles),
      "users": (BuildContext context) => UsersPage(fonts,titles),
      "splash": (BuildContext context) => SplashPage(),
      "products/product": (BuildContext context) => ProductPage(fonts,titles),
      "users/user": (BuildContext context) => UserPage(fonts,titles),
      "add-product": (BuildContext context) => AddProductPage(fonts,titles)
    };
