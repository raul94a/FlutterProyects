import 'package:flutter/material.dart';
import 'package:repaso_examen_ii/providers/products_provider.dart';
import 'package:repaso_examen_ii/providers/users_provider.dart';

class UserPage extends StatelessWidget {
  final fonts;
  final titles;
  UserPage(this.fonts, this.titles);
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(args['nombre']),
      ),
      body: FutureBuilder(
          initialData: {},
          future: ProductsProvider.getUserProducts((args['id'])),
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return _UserInformation(snapshot.data, args, fonts);
            }
          }),
    );
  }
}

class _UserInformation extends StatelessWidget {
  final userProducts;
  final user;
  final fonts;
  _UserInformation(this.userProducts, this.user, this.fonts);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(user['img']),
          ),
          ListTile(
            title: Text(user['nombre'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fonts[0]['size'] + 0.1)),
            subtitle: Text(user['email'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fonts[1]['size'] + 0.1)),
          ),
          Text('Productos a la venta',
              style: TextStyle(fontSize: fonts[0]['size'] + 0.1)),
          Column(
            children: [
              ...(userProducts as List)
                  .map(
                    (element) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'products/product',
                            arguments: element);
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.elliptical(50, 15),
                                bottomLeft: Radius.elliptical(50, 105),
                                topLeft: Radius.elliptical(50, 15),
                                bottomRight: Radius.elliptical(50, 105)),
                            side: const BorderSide(color: Colors.black)),
                        margin: const EdgeInsets.only(top: 5, bottom: 15),
                        color: Colors.grey,
                        elevation: 10,
                        child: Column(
                          children: [
                            //foto
                            Image.network(
                              element['img'],
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                            //nombre
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(element['nombre'])),
                            //precio
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: Text('${element['precio']} €')),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          ),
        ],
      ),
    );
  }
}
