import 'package:flutter/material.dart';
import 'package:proyecto91121/provider/prueba_provider.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({Key? key}) : super(key: key);

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  String? image;
  String? name;
  Map<String, String> data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          initialData: [],
          future: PruebaProvider.get(3),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Row(
                children: [
                  Text(snapshot.data['nombre']),
                  Expanded(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: FittedBox(
                          child: snapshot.data['img'] != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(snapshot.data['img']))
                              : CircleAvatar(
                                  child: Text(
                                      (snapshot.data['nombre'] as String)
                                          .substring(0, 2)),
                                )),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      body: FutureBuilder(
        initialData: [],
        future: PruebaProvider.get(1),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            print('abajo');
            print(snapshot.data);
            return snapshot.data != null
                ? Column(
                    children: [
                      Center(
                        child: Text(snapshot.data['nombre']),
                      ),
                      snapshot.data['img'] != null
                          ? Container(
                              height: 500,
                              width: 500,
                              child: Image.network(
                                snapshot.data['img'],
                                centerSlice: Rect.fromCircle(
                                    center: Offset(0, 0), radius: 20),
                              ),
                            )
                          : Text('Usuario sin foto')
                    ],
                  )
                : Center(
                    child: Text('ID INCORRECTA'),
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.backpack),
      ),
    );
  }
}
