import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as or;
import 'dart:math';

class OrderItem extends StatefulWidget {
  final or.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  var _expanded = false;
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.order.amount}'),
            subtitle:
                Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 10, 180),
              child: ListView(
                children: [
                  ...widget.order.products.map((prod) {
                    print(prod);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(prod.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('${prod.quantity}x ${prod.price}€ '),
                      ],
                    );
                  }).toList()
                ],
              ),
            )
        ],
      ),
    );
  }
}
