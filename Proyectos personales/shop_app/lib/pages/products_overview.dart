import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/pages/cart_screen.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
// import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';
import 'package:flutter_complete_guide/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

enum FilterOptions { Favorites, All }

class ProductsOverview extends StatefulWidget {
  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool _showFavorites = false;
  bool _isInit = true;
  bool _isLoading = false;
  bool _emptyProducts = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context)
          .fetchAndSetProduct()
          .then((value) => setState(() {
                _isLoading = false;
                _emptyProducts = false;
              }))
          .onError((error, stackTrace) => setState(() {
                _isLoading = false;
                _emptyProducts = true;
              }));
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer =
    //     Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (FilterOptions value) {
                setState(() {
                  if (value == FilterOptions.Favorites) {
                    _showFavorites = true;
                  } else {
                    _showFavorites = false;
                  }
                });
              },
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Favorites'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                        child: Text('Show all'), value: FilterOptions.All),
                  ]),
          Consumer<Cart>(
            builder: (_, cartData, child) =>
                Badge(child: child, value: cartData.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.pushNamed(context, CartScreen.routeName),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _emptyProducts
              ? Center(
                  child: Text('No products to show'),
                )
              : ProductsGrid(_showFavorites),
      drawer: AppDrawer(),
    );
  }
}
