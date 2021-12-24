import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product_model.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  // final String title;
  // final double? price;
  // ProductDetail(this.title);
  static const routeName = '/product/detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    //...
    final Product product = Provider.of<ProductsProvider>(context)
        .products
        .firstWhere((e) => e.id == productId);
    print(product);
    return Scaffold(
        appBar: AppBar(title: Text(product.title)),
        body: Column(
          children: [
            Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              '${product.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),

            //////
            ///
            ///
            ///
          ],
        ));
  }
}
