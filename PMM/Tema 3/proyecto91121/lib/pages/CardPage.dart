import 'package:flutter/material.dart';
import 'package:proyecto91121/widgets/card_info.dart';
import 'package:url_launcher/url_launcher.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('card page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _cardTipo1(),
          CardInfo(
            'Probando el WIDGET',
            'Este widget es muy bueno y te redirigue a youtube',
            infoText: 'youtube',
            url: 'https://youtube.com',
          ),
          CardInfo(
            'Probando el WIDGET',
            'Este Widget no te lleva a ningún lado, solo de vuelta',
          ),
          _card2img()
        ],
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo_album),
          )
        ],
      ),
    );
  }

  Widget _card2() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Información de la tarjeta'),
            subtitle: Text(
                'LoremLOREMlfkljdsfklañdnfklaNFklñfnkDNASJKNGKADSNGFKLAÑJIILASGJNKASÑGNVLKÑEFNKLADBNLFJKLDFBNEL´FMREJKBNRSKLÑFGNDFKBSERKLVMADJKBNLESVKJBNLRSGNVKHLBN '),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Volver',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
                Container(
                  //color: Colors.blue,

                  decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(2, 5),
                            blurRadius: 10,
                            spreadRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(20)),

                  child: TextButton(
                    onPressed: () async {
                      const url = 'https://web.iesfernandoiii.es/';
                      if (await canLaunch(url)) {
                        await launch(url,
                            forceWebView: true, enableJavaScript: true);
                      } else {
                        throw "cannot open url";
                      }
                    },
                    child: Text(
                      '+INFO',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _card2img() {
    return Card(
      elevation: 20,
      shadowColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          FadeInImage(
              height: 220,
              fadeInDuration: Duration(milliseconds: 600),
              fit: BoxFit.contain,
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(
                  'https://www.akamai.com/content/dam/site/im-demo/perceptual-standard.jpg?imbypass=true',
                  scale: 1)),
          /* Image.network(
                'https://www.akamai.com/content/dam/site/im-demo/perceptual-standard.jpg?imbypass=true'),*/
          Text('Title'),
        ],
      ),
    );
  }
}
