import 'package:exament3/widgets/botones_login.dart';
import 'package:exament3/widgets/input_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _usuario = '';
  String _pass = '';
  String _rol = 'sin rol';
  bool botonActivo = false;
  void setUsuario(user) => setState(() => _usuario = user);
  void setPass(password) => setState(() => _pass = password);
  void setRol(rol) => setState(() => _rol = rol);
  void checkBoton() {
    setState(() {
      if (_usuario == 'usuario' &&
          _pass == 'Olivo.2021' &&
          _rol == 'profesorado')
        botonActivo = true;
      else
        botonActivo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> roles =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    print(roles);
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/logo_insti2.jpg'),
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: InputLogin('Nombre de usuario', 'Usuario', 'Usuario',
                    setUsuario, checkBoton, false),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: InputLogin('Contraseña', 'Introduce la contraseña',
                    'Contraseña', setPass, checkBoton, true),
              ),
              _crearSelect(roles),
              BotonLogin(botonActivo)
            ],
          ),
        ));
  }

  List<DropdownMenuItem<String>> _getOpciones(List roles) {
    List<DropdownMenuItem<String>> lista = [];
    roles.forEach((element) {
      lista.add(DropdownMenuItem(child: Text(element), value: element));
    });
    return lista;
  }

  Widget _crearSelect(List users) {
    return DropdownButton(
      value: _rol,
      items: _getOpciones(users),
      onChanged: (valor) {
        setRol(valor);
        checkBoton();
      },
    );
  }
}
