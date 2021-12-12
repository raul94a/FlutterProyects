import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_complete_guide/pages/product_detail_page.dart';
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
        ChangeNotifierProvider(
      create: (ctx) => ProductsProvider(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductsOverview(),
        routes: {ProductDetail.routeName: (ctx) => ProductDetail()},
      ),
    );
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
