import 'dart:io';

import 'package:flutter/material.dart';
import 'package:repaso_examen_ii/config/config.dart';
import 'package:repaso_examen_ii/providers/users_provider.dart';

class UsersPage extends StatefulWidget {
  // final routes;
  // UsersPage(this.routes);
  final fonts;
  final titles;
  UsersPage(this.fonts, this.titles);
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<Map<String, dynamic>> routes = [];

  List<Map<String, dynamic>> _tabBarRoutes() {
    return routes.where((element) => element['tabBar'] == true).toList();
  }

  List<Widget> _createTabs() {
    return _tabBarRoutes()
        .map((e) => Tab(
              icon: IconButton(
                  onPressed: () => Navigator.pushNamed(context, e['route'],
                      arguments: routes),
                  icon: Icon(icons[e['icon']])),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      routes = ModalRoute.of(context)!.settings.arguments
          as List<Map<String, dynamic>>;
    });
    return DefaultTabController(
        initialIndex: 0,
        length: _tabBarRoutes().length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.titles[2]['texto']! as String),
            bottom: TabBar(
              tabs: [..._createTabs()],
            ),
          ),
          body: FutureBuilder(
              future: UsersProvider.getAll(),
              initialData: [],
              builder: (context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return _InfoUsers(snapshot.data, widget.fonts);
                }
              }),
        ));
  }
}

class _InfoUsers extends StatelessWidget {
  final users;
  final fonts;
  _InfoUsers(this.users, this.fonts);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 10,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //INFO DE TEXTO
                      Container(
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(237, 230, 241, 1))),
                        child: Center(
                          child: ListTile(
                              title: Text(
                                users[index]['nombre'],
                                style: TextStyle(
                                    fontSize: fonts[0]['size'] + 0.1),
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(users[index]['email'],
                                  softWrap: true,
                                  textScaleFactor: 0.9,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          fonts[1]['size'] + 0.1))),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.white),
                              BoxShadow(color: Colors.black)
                            ],
                            border: Border.all(
                                color: Color.fromRGBO(237, 240, 251, 1),
                                width: 2)),
                        width: 150,
                        height: 150,
                        child: Image.network(
                          users[index]['img'],
                          fit: BoxFit.fill,
                        ),
                      ),
                      //LA FOTO
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'users/user',
                              arguments: users[index]);
                        },
                        child: Text('VER INFO',
                            style: TextStyle(
                                fontSize: fonts[2]['size'] + 0.1)),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black))))
              ],
            ),
          );
        });
  }
}
