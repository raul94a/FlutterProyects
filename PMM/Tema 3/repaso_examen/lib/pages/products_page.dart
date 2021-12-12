import 'package:flutter/material.dart';
import 'package:repaso_examen/model/product_model.dart';
import 'package:repaso_examen/providers/product_provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            SingleChildScrollView(
              child: FutureBuilder(
                  future: ProductProvider.get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final data = snapshot.data;
                      print(data);
                      return Column(children: _getProducts(data, context));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _getProducts(List<Product> prods, context) {
    return prods.map((e) {
      return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "products/product", arguments: e);
          },
          child: Card(
            elevation: 10,
            child: Column(
              children: [
                Container(
                    width: 50,
                    height: 50,
                    child: FadeInImage(
                      placeholder: AssetImage('assets/loading.gif'),
                      image: NetworkImage(e.avatar!),
                    )),
                Text(e.nombre!)
              ],
            ),
          ));
    }).toList();
  }
}
