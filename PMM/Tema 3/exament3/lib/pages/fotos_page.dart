import 'package:exament3/providers/fotos_provider.dart';
import 'package:flutter/material.dart';

class FotosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Fotos'),backgroundColor: Colors.indigo,),
        body: FutureBuilder(
            future: FotosProvider.get(),
            initialData: [],
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                print(snapshot.data.runtimeType);
                return _ListaFotos(snapshot.data);
              }
            }));
  }
}

class _ListaFotos extends StatelessWidget {
  List<dynamic> data;
  _ListaFotos(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: (data as List).length,
        itemBuilder: (_, index) {
          dynamic url = data[index]['src']['large'];
          print(data[index]['src']);
          print(url);

          return Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: FadeInImage(
                fit: BoxFit.fill,
                placeholder: AssetImage('assets/load.gif'),
                image: NetworkImage(url),
              ));
        });
  }
}
