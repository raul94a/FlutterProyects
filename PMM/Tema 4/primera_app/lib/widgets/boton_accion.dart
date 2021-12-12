import 'package:flutter/material.dart';
import 'package:primera_app/pages/basico_page.dart';
import 'package:url_launcher/url_launcher.dart';

class BotonAccion extends StatelessWidget {
  final icon;
  final texto;
  final VoidCallback? function;
  final Function(SocialMedia)? func;
  BotonAccion(this.icon, this.texto, {this.function = null, this.func});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            icon: Icon(
              icon,
              size: 40,
              color: Colors.blue,
            ),
            onPressed: function),
        SizedBox(
          height: 5,
        ),
        Text(texto, style: TextStyle(fontSize: 15, color: Colors.blue))
      ],
    );
  }
}
