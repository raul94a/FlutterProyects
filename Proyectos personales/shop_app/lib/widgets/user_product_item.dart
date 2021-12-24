import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/pages/edit_product_page.dart';
import 'package:flutter_complete_guide/providers/product_model.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  //voy a editar esta parte del código porue me parece más lógico pasar el producto completo
  // final String title;
  // final String imageUrl;
  final Product product;
  UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                //vamos a editar el producto!
                Navigator.pushNamed(context, EditProductPage.routeName,
                    arguments: product);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                //show alert!!!!
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Remove item'),
                        content: Text('Are you sure?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                final productsData =
                                    Provider.of<ProductsProvider>(context,
                                        listen: false);
                                try {
                                  await productsData.removeItem(product.id);
                                } catch (err) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    'Deletion failed!',
                                    textAlign: TextAlign.center,
                                  )));
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text('SI')),
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('No'))
                        ],
                      );
                    });
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
