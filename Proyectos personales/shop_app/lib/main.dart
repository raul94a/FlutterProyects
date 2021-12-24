import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/pages/auth_screen.dart';
import 'package:flutter_complete_guide/pages/cart_screen.dart';
import 'package:flutter_complete_guide/pages/add_product_screen.dart';
import 'package:flutter_complete_guide/pages/edit_product_page.dart';
import 'package:flutter_complete_guide/pages/orders_page.dart';
import 'package:flutter_complete_guide/pages/product_detail_screen.dart';
import 'package:flutter_complete_guide/pages/splash_screen.dart';
import 'package:flutter_complete_guide/pages/user_products_screen.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/pages/products_overview.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //es nuestro state manager
    return //ChangeNotifierProvider(
        //nueva version se usa create, en la antigua es builder
        //puede hacerse de otra forma, e sdecir, sin unsar el context!
        // create: (_) => ProductsProvider() ,
        //ChangeNotifierProvider.value(
        //esta es la forma de hacerlo sin depender del ctx, con el constructor value
        //value: ProductsProvider(),

        //ACTUALIZACIÓN 20/12/2021 => AÑADIMOS EL MULTIPROVIDER

        // ChangeNotifierProvider(
        MultiProvider(
            providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            update: (ctx, auth, previousProducts) => ProductsProvider(
                auth.token,
                auth.user,
                previousProducts == null ? [] : previousProducts.products),
          ),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previosOrders) => Orders(auth.token, auth.user,
                previosOrders == null ? [] : previosOrders.orders),
          )
        ],
            child: Consumer<Auth>(
              builder: (context, auth, _) => MaterialApp(
                title: 'MyShop',
                theme: ThemeData(
                    primarySwatch: Colors.purple,
                    accentColor: Colors.deepOrange,
                    fontFamily: 'Lato'),
                home: !auth.isAuth
                    ? FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (context, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                                ? SplashScreen()
                                : AuthPage())
                    : ProductsOverview(),
                // initialRoute: AuthPage.routeName,
                routes: {
                  AuthPage.routeName: (ctx) => AuthPage(),
                  EditProductPage.routeName: (ctx) => EditProductPage(),
                  OrdersPage.routeName: (ctx) => OrdersPage(),
                  ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                  CartScreen.routeName: (ctx) => CartScreen(),
                  UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                  EditProductScreen.routeName: (ctx) => EditProductScreen(),
                },
              ),
            ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
