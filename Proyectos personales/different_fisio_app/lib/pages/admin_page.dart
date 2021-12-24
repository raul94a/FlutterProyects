import 'package:different_fisio_app/config/app_config.dart';
import 'package:different_fisio_app/config/custom_box_dec.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  String appbarTitle = 'ADMIN PAGE';
  final List<dynamic> config;
  AdminPage(this.config);
  @override
  Widget build(BuildContext context) {
    print(config);
    return GridView.builder(
        padding: EdgeInsets.all(20),
        itemCount: config.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 2 / 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, config[index]['nombre']);
            },
            child: Container(
              decoration: customBoxDecoration(),
              width: 200,
              height: 150,
              child: Column(
                children: [Icon(iconConfigTwo[config[index]['icono']])],
              ),
            ),
          );
        });
  }
}
