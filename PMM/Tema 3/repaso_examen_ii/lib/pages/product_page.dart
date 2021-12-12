import 'package:flutter/material.dart';
import 'package:repaso_examen_ii/providers/users_provider.dart';

class ProductPage extends StatelessWidget {
  final fonts;
  final titles;
  ProductPage(this.fonts, this.titles);
  @override
  Widget build(BuildContext context) {
    //necesito el producto para generar la pagina
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('${titles[3]['texto']! as String} - ${args['nombre']}'),
      ),
      body: FutureBuilder(
          future: UsersProvider.getUser(args['user']),
          initialData: {},
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return _InfoProducto(snapshot.data, args, fonts);
            }
          }),
    );
  }
}

class _InfoProducto extends StatelessWidget {
  final user;
  final args;
  final fonts;
  _InfoProducto(this.user, this.args, this.fonts);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                args['img'],
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 2,
              ),
              //nombre
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(args['nombre'],
                      style: TextStyle(fontSize: fonts[0]['size']))),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(args['descripcion'],
                      style: TextStyle(fontSize: fonts[1]['size'] + 0.1))),
              //precio
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('${args['precio']} €',
                    style: TextStyle(fontSize: fonts[1]['size'] + 0.1)),
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('${user['nombre']}',
                      style: TextStyle(fontSize: fonts[1]['size'] + 0.1))),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('${user['email']}',
                      style: TextStyle(fontSize: fonts[2]['size'] + 0.1))),
              Image.network(user['img'])
            ],
          ),
        ),
      ),
    );
  }
}
