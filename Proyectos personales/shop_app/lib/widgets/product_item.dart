import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/pages/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../pages/product_detail_page.dart';
import '../providers/product_model.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  ProductItem();
  @override
  Widget build(BuildContext context) {
    //Este product es el que el ChangeNotifierProvider.value le pasa al child
    final product = Provider.of<Product>(context, listen: false);
    //HAY otra forma de utilizar el manejador de estado, que es igual que el approach del provider
    //este widget se llama Consumer, al que hay que indicar la CLASE que va a CONSUMIR
    final cart = Provider.of<Cart>(context, listen: false);

    print('rebuild');
    return GridTile(
        child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id),
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
                    !product.fav ? Icons.favorite_border : Icons.favorite,
                    color: Theme.of(context).accentColor,
                  )),
              //REFERENCIA AL CHILD DEL BUILDER!
              // child: Text('Never CHANGES!'),
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                //Scaffold of context te selecciona el Scaffold MAS CERCANO, que ne este scaso es el de Products overview
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added to cart'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      //ene l caso de introducir un proudcto po rerror... puedo deshacer el cambio
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ));
              },
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
