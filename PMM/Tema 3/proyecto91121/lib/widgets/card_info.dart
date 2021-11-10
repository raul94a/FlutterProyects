import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardInfo extends StatelessWidget {
  String? url;
  final title;
  final subtitle;
  String? infoText = null;
  CardInfo(this.title, this.subtitle, {this.infoText, this.url});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('$title'),
            subtitle: Text('$subtitle'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'home');
                  },
                  child: Text(
                    'Volver',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
                url != null
                    ? Container(
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
                            if (await canLaunch(url!)) {
                              await launch(url!,
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
                      )
                    : Center(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
