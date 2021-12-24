import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart';
import 'package:meal_app/services/auth.dart';
import 'package:provider/provider.dart'; // to use Emoji collection

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String usuario = '';
  String pass = '';

  bool _isLoading = false;
  @override
  void _showErrorDialog(error) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              title: Text('Se ha producido un error'),
              content: Text(error),
              actions: [
                TextButton(
                  child: Text('aceptar'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ]);
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(93, 84, 164, 1),
            Color.fromRGBO(124, 120, 184, 1)
          ], begin: Alignment.topRight, end: Alignment.bottomRight)),
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.antiAlias,
            children: [
              //decoración del fondo // spread operator para pintar cada elemento de la lista
              ..._buildBackground(),
              //formulario
              _buildForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRotatedContainerD(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      right: MediaQuery.of(context).size.width * 0.40,
      child: Transform.rotate(
        angle: 15,
        child: Container(
          width: MediaQuery.of(context).size.width * 1.2,
          height: MediaQuery.of(context).size.width * 1.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRotatedContainerC(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * -0.05,
      left: MediaQuery.of(context).size.width * 0.5,
      child: Transform.rotate(
        angle: 15,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.56,
          height: MediaQuery.of(context).size.width * 0.44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(115, 100, 182, 1)),
        ),
      ),
    );
  }

  Widget _buildRotatedContainerB(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.30,
      left: MediaQuery.of(context).size.width * 0.10,
      child: Transform.rotate(
        angle: 15,
        child: Container(
          width: MediaQuery.of(context).size.height * 0.9,
          height: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(93, 84, 164, 1),
                Color.fromRGBO(106, 103, 158, 1)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
      ),
    );
  }

  Widget _buildRotatedContainerA(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.80,
      left: MediaQuery.of(context).size.width * 0.40,
      child: Transform.rotate(
        angle: 15,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromRGBO(126, 123, 185, 1))),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  color: Colors.black.withOpacity(0.55),
                  blurRadius: 15,
                  //offset: Offset.infinite,
                  spreadRadius: 7),
            ],
            color: Color.fromRGBO(93, 84, 163, 0.55),
            //border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(25)),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.6,
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
        // height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)),
              child: const Text('RecetApp',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2.5,
                      fontFamily: 'RobotoCondensed',
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            _buildTextField(
                hintText: 'Introduce tu usuario', icon: Icons.people),
            const SizedBox(
              height: 5,
            ),
            _buildTextField(
                hintText: 'Introduce tu contraseña', icon: Icons.lock),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildButton(
                    text: 'Registrarse', color: Colors.deepPurpleAccent),
                const SizedBox(
                  width: 25,
                ),
                _buildButton(text: 'Iniciar sesión'),
                const SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({String hintText = '', IconData icon = Icons.people}) {
    // final emojis = Emoji.byGroup(EmojiGroup.foodDrink);
    // emojis.forEach((e) {
    //   if (e.toString() == '🍌') {
    //     print(e.toString());
    //     print('PALATNO ENCONTRADO');
    //   }
    //   ;
    // });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        obscureText: icon == Icons.lock ? true : false,
        obscuringCharacter: ('\u{263B}'),
        onChanged: (value) {
          setState(() {
            //usuario
            if (icon == Icons.people) {
              usuario = value;
            }
            //contraseña
            else {
              pass = value;
              print(pass);
            }
          });
        },
        cursorColor: Colors.pink,
        style: const TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
        decoration: InputDecoration(

            // errorText: 'Algún dato es incorrecto',
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(25),
            filled: true,
            hintText: hintText,
            prefixIcon: Icon(icon)),
      ),
    );
  }

  Widget _buildButton({String text = '', color = Colors.pink}) {
    return _isLoading && text != 'Registrarse'
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ElevatedButton(
            onPressed: () async {
              //Registro de usuario en la bd
              if (text == 'Registrarse') {
              }
              //Inicio de sesión
              else {
                setState(() {
                  _isLoading = true;
                });
                // if (usuario == 'a' && pass == 'a') {
                //Navigator.pushReplacementNamed(context, 'tab');
                try {
                  await Provider.of<Auth>(context, listen: false)
                      .login(usuario, pass);
                } on HttpException catch (err) {
                  _showErrorDialog(err.toString());
                } catch (err) {
                  _showErrorDialog(err.toString());
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
                // }
              }
            },
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            style: (ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => color))),
          );
  }

  _buildBackground() => [
        _buildRotatedContainerA(context),
        _buildRotatedContainerB(context),
        _buildRotatedContainerC(context),
        _buildRotatedContainerD(context)
      ];
}
