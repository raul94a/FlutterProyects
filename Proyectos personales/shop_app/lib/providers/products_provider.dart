import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/http_exceptions.dart';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  String _token;
  String _user;
  //se inicializa en el constructor el this products para inicializarlo o bien con lista vacía o bien con los productos
  ProductsProvider(this._token, this._user, this._products);

  List<Product> get products {
    // if (_showFavoritesOnly) {
    //   return _products.where((element) => element.fav).toList();
    // }
    return [..._products];
  }

  Future<void> addProduct(Product prod) async {
    await http
        .post(
            Uri.parse(
                'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$_token'),
            body: jsonEncode({
              'title': prod.title,
              'price': prod.price,
              'description': prod.description,
              'imageUrl': prod.imageUrl,
              'user': _user
            }))
        .then((value) {
      prod.id = jsonDecode(value.body)['name'];
    }).catchError((error) => throw error);

    _products.add(Product(
        id: prod.id,
        title: prod.title,
        description: prod.description,
        price: prod.price,
        imageUrl: prod.imageUrl));
    notifyListeners();
  }

  List<Product> get favProducts {
    return _products.where((prod) => prod.fav).toList();
  }

  Product findById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProduct([bool fetchOnlyUserProducts = false]) async {
    var filterByUser =
        fetchOnlyUserProducts ? '&orderBy="user"&equalTo="$_user"' : '';
    Uri uri = Uri.parse(
        'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$_token$filterByUser');
    List<Product> fetchedProducts = [];
    _products.clear();
    try {
      final res =
          await http.get(uri).then((value) => json.decode(value.body)) as Map;
      if (res == null) {
        throw HttpException('La lista de productos está vacía');
      }
      print(res);
      res.forEach((key, value) {
        _products.add(Product.fromMap(key, value));
        notifyListeners();
      });
      print(_products);
    } catch (error) {
      throw error;
    }
  }

  Future<void> removeItem(String id) async {
    await http
        .delete(Uri.parse(
            'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/products/${id}.json?auth=$_token'))
        .then((value) {
      int statusCode = value.statusCode;
      if (statusCode < 300) {
        _products.removeWhere((element) => element.id == id);
        notifyListeners();
      } else {
        throw HttpException('Could not delete the product');
      }
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Future<void> updateProduct(String id, Product product) async {
    Product updatedProduct =
        _products.firstWhere((element) => element.id == id);

    updatedProduct.title = product.title;
    updatedProduct.price = product.price;
    updatedProduct.description = product.description;
    updatedProduct.imageUrl = product.imageUrl;

    await http.patch(
        Uri.parse(
            'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/products/${id}.json?auth=$_token'),
        body: json.encode({
          'title': updatedProduct.title,
          'price': updatedProduct.price,
          'description': updatedProduct.description,
          'imageUrl': updatedProduct.imageUrl
        }));
    notifyListeners();
  }
/**
 * Métodos y variables comentadas en este archivo: EXPLICACIÓN
 * Manejar de forma GLOBAL la lógica que afecta a un SOLO Widget no es correcto.
 * En ese caso se debería incrustar la lógica que afecta al widget dentro de él mismo.
 * Eso significa que al haber lógica, es posible que sucedan cambios de ESTADO
 * en este caso cambiaría el estado de favorito a no favorito y viceversa. 
 * Como hay cambio de estado asociado a un cambio en la UI, significa que esto se debe controlar en un
 * stateful widget. Así que esta lógica será añadida en ese tipo de widget...
 */
  // var _showFavoritesOnly = false;

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
}
