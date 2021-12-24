import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static String routeName = 'cart';
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    return Scaffold(
        appBar: AppBar(title: Text('')),
        body: Column(
          children: [
            _buildInfoCard(cart, context),
            SizedBox(height: 10),
            if (cart.totalAmount != 0)
              _buildCartListView(cart)
            else
              Center(child: Text('El carro está vacío'))
          ],
        ));
  }

  Widget _buildInfoCard(Cart cart, context) {
    return Card(
        margin: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total', style: TextStyle(fontSize: 20)),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Chip(
              backgroundColor: Colors.black,
              label: Text(
                '${cart.totalAmount.toStringAsFixed(2)} €',
                style: TextStyle(color: Colors.white),
              ),
            ),
            OrderButton(cart)
          ],
        ));
  }

  Widget _buildCartListView(Cart cart) {
    return Expanded(
      child: ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (ctx, i) {
            return CartItemWidget(
                productId: cart.items.keys.toList()[i],
                id: cart.items.values.toList()[i].id,
                title: cart.items.values.toList()[i].title,
                quantity: cart.items.values.toList()[i].quantity,
                price: cart.items.values.toList()[i].price);
          }),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;
  OrderButton(this.cart);
  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : ElevatedButton(
            onPressed: widget.cart.totalAmount <= 0
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<Orders>(context, listen: false).addOrder(
                        widget.cart.items.values.toList(),
                        widget.cart.totalAmount);

                    await widget.cart.clear();
                    setState(() {
                      _isLoading = false;
                    });
                  },
            child: Text('ORDER NOW'));
  }
}
