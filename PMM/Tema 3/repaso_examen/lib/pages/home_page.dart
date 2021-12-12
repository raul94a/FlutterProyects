import 'package:flutter/material.dart';
import 'package:repaso_examen/routes/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print(rutas);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repasodfas'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 400,
          child: FutureBuilder(
              future: listaRutas(),
              initialData: [],
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  final List<String> data = snapshot.data;
                  final List<String> treatedData =
                      data.where((d) => !d.contains('/')).toList();
                  print(data);
                  // return Center();
                  return ListView.builder(
                    itemCount: treatedData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Icon(Icons.router),
                          Text(treatedData[index]),
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, treatedData[index]);
                              },
                              icon: Icon(Icons.arrow_right))
                        ],
                      );
                    },
                  );
                }
              }),
        ),
      ),
    );
  }
}
