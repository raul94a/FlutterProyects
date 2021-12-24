import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:http/http.dart' as http;

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  //Mapa que utiliza como key la id del producto...cada CartItem tiene su propia id utilizando fecha
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void updateCart(bool undo, String productId) async {
    int index = _items.keys.toList().indexOf((productId));
    //LO UTILIZAMOS PARA OBTENER EL VALUE CONCRETO
    CartItem cartItem = _items.values.toList()[index];
    //URL
    int quantity = !undo ? cartItem.quantity + 1 : cartItem.quantity - 1;
    Uri url = Uri.parse(
        'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/cart/${cartItem.id}.json');
    await http.patch(url, body: json.encode({'quantity': quantity}));
  }

  void addItem(String productId, double price, String title) async {
    //buscar le producto en el carro
    String cartFirebaseId = '';
    if (_items.containsKey(productId)) {
      await updateCart(false, productId);
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: title,
              quantity: value.quantity + 1,
              price: price));
    } else {
      //el producto no está en el carro...

      await http
          .post(
              Uri.parse(
                  'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/cart.json'),
              body: json.encode({
                'productId': productId,
                'title': title,
                'price': price,
                'quantity': 1
              }))
          .then((value) => cartFirebaseId = jsonDecode(value.body)['name']);
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: cartFirebaseId, title: title, quantity: 1, price: price));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void remoteItem(String id) async {
    await http.delete(Uri.parse(
        'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/cart/$id.json'));
    _items.remove(id);

    notifyListeners();
  }

  void removeSingleItem(String productId) async {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      await updateCart(true, productId);
      _items.update(
          productId,
          (existingCardItem) => CartItem(
              id: existingCardItem.id,
              title: existingCardItem.title,
              quantity: existingCardItem.quantity - 1,
              price: existingCardItem.price));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() async {
    _items = {};
    await http.delete(Uri.parse(
        'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/cart.json'));
    notifyListeners();
  }
}
