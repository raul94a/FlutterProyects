import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/products_grid.dart';

class ProductsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: [
            PopupMenuButton(
                icon: Icon(Icons.more_vert),
                onSelected: (int value) {
                  print(value);
                },
                itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text('Favorites'),
                        value: 0,
                      ),
                      PopupMenuItem(child: Text('Show all'), value: 1),
                    ]),
          ],
        ),
        body: ProductsGrid());
  }
}
