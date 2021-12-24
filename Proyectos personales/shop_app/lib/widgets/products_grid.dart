import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;
  ProductsGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    //la data del provider de la clase ProductsProvider
    final productsData = Provider.of<ProductsProvider>(context);
    //accedemos la getter creado...
    final products = showFav ? productsData.favProducts : productsData.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      //al igual que en elmain se utiliza el constructor value del provider
      //el constructor value ELIMINA automaticamente el products[i] cuando la pagina es reemplazada, evitando memory leaks
      itemBuilder: (_, i) => ChangeNotifierProvider.value(
        //este value es el que recibe el ProductItem
        value: products[i],
        child: ProductItem(),
      ),
    );
  }
}
