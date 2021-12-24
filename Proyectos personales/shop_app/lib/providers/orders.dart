import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/providers/cart.dart' show CartItem;
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;
  OrderItem({this.id, this.amount, this.products, this.date});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  String _token;
  String _user;
  Orders(this._token, this._user, this._orders);

  Future<void> fetchAndSetOrders() async {
    _orders.clear();
    final res = await http
        .get(Uri.parse(
            'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$_token&orderBy="user"&equalTo="$_user"'))
        .then((value) => jsonDecode(value.body)) as Map<String, dynamic>;
    print(res);
    res.forEach((key, value) {
      double amount = value['amount'];
      DateTime date = DateTime.parse((value['date']));
      List<CartItem> cartItems = (value['products'] as List).map((e) {
        return CartItem(
            id: e['product'],
            title: e['title'],
            quantity: e['quantity'],
            price: e['price']);
      }).toList();

      _orders.add(
          OrderItem(id: key, amount: amount, date: date, products: cartItems));
    });
  }

  void addOrder(List<CartItem> cartProducts, double total) async {
    //por ahora vamos a guardas los objetos Completos...
    String orderFirebaseId = '';
    final date = DateTime.now();
    Map<String, dynamic> mapa() {
      return {
        'amount': total,
        'date': date.toString(),
        'user': _user,
        'products': cartProducts.map((e) {
          //vamos a buscar la key
          // int index = Cart().items.values.toList().indexOf(e);
          // String productId = Cart().items.keys.toList()[index];
          return {
            'product': e.id,
            'title': e.title,
            'price': e.price,
            'quantity': e.quantity
          };
        }).toList()
      };
    }

    await http
        .post(
            Uri.parse(
                'https://shopapp-d9242-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$_token'),
            body: jsonEncode(mapa()))
        .then((value) => orderFirebaseId = jsonDecode(value.body)['name']);
    _orders.insert(
        0,
        OrderItem(
            id: orderFirebaseId,
            amount: total,
            date: date,
            products: cartProducts));
    notifyListeners();
  }
}
