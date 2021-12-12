import 'package:flutter/material.dart';

class BotonLogin extends StatelessWidget {
  bool botonActivo;
  BotonLogin(this.botonActivo);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const ElevatedButton(onPressed: null, child: Text('Registrarse')),
        ElevatedButton(
            onPressed: !botonActivo
                ? null
                : () {
                    Navigator.pushNamed(context, 'home');
                  },
            child: const Text('Iniciar'))
      ],
    );
  }
}
