import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import 'add_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProducts(context) async {
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: _refreshProducts(context),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _refreshProducts(context),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Consumer<ProductsProvider>(
                            builder: (context, products, _) => ListView.builder(
                              itemCount: products.products.length,
                              itemBuilder: (_, i) => Column(
                                children: [
                                  UserProductItem(products.products[i]),
                                  Divider(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )));
  }
}
