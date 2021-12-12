import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Localizacion')),
        body: Card(
          child: Column(
            children: [
              Image(
                height: 250,
                image: AssetImage(
                  'assets/ies.PNG',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pushNamed(context, "home"),
                      child: Text('Volver')),
                  ElevatedButton(
                    onPressed: () async {
                      if (await canLaunch('https://web.iesfernandoiii.es/')) {
                        await launch('https://web.iesfernandoiii.es/',
                            forceWebView: true, enableJavaScript: true);
                      } else {
                        throw "cannot open url";
                      }
                    },
                    child: Text(
                      'Ir a web',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
