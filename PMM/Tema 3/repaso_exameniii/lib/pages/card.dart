import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //vamos a practicar los cards
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Column(
                children: [
                  Container(
                    // padding: EdgeInsets.all(15),
                    child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://okdiario.com/img/2020/09/16/como-es-el-pajaro-oriol.jpg')),
                  ),
                  Text('PAJARO  ')
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
