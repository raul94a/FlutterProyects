import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/pages/product_detail_page.dart';
import 'package:flutter_complete_guide/providers/product_model.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  ProductItem();
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    //HAY otra forma de utilizar el manejador de estado, que es igual que el approach del provider
    //este widget se llama Consumer, al que hay que indicar la CLASE que va a CONSUMIR
    print('rebuild');
    return GridTile(
        child: GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(ProductDetail.routeName, arguments: product.id),
            child: Image.network(product.imageUrl, fit: BoxFit.cover)),
        footer: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              //CHILD ES UN WIDGET. este WIDGET puede declararse (linea comentada más abajo) para referise a el en otra parte dentro del widget
              //que el builder devuelve(iconButton en este caso)
              //esto se utilizaría para casos donde hay contenido ESTATICO, es decir que no se actuailzan
              builder: (ctx, product, child) => IconButton(
                  onPressed: () {
                    product.toggleFavouriteStatus();
                  },
                  icon: Icon(
                    product.fav ? Icons.favorite_border : Icons.favorite,
                    color: Theme.of(context).accentColor,
                  )),
                  //REFERENCIA AL CHILD DEL BUILDER!
              // child: Text('Never CHANGES!'),
            ),
            trailing: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ));
  }
}

/*
Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(color: Colors.black54),
          child: Center(
            child: Text(
              '$id - $title',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        )
*/