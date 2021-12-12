import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:series_pelis_app/providers/multimedia_provider.dart';
import '../models/multimedia.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _multimedia = [];
  Future<dynamic> getMultimedia() async {
    _multimedia = await MultimediaProvider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('adfas'),
        ),
        body: FutureBuilder(
            future: MultimediaProvider.getAll(),
            initialData: [],
            builder: (_, AsyncSnapshot snapshot) {
              print(snapshot.data);
              List<Multimedia> multimedia = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator.adaptive();
              } else {
                return Column(
                  children: [
                    Text(multimedia[0].id.toString()),
                    Text(multimedia[0].nombre.toString()),
                    Text(multimedia[0].comentarios.toString())
                  ],
                );
              }
            }));
  }
}
