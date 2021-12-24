import 'package:different_fisio_app/services/config_provider.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String cargando = 'cargando';

  void reloadLoading() async => {
        await Future.delayed(
            Duration(seconds: 1), () => setState(() => cargando += '.'))
      };
  load() async {
    await Future.delayed(Duration(seconds: 1), () async {
      setState(() {
        cargando += '.';
      });
      await Future.delayed(Duration(seconds: 1), () async {
        setState(() {
          cargando += '.';
        });
        await Future.delayed(Duration(seconds: 1), () async {
          setState(() {
            cargando += '.';
          });
          await Future.delayed(Duration(milliseconds: 500), () async {
            final config = await ConfigProvider.getFromMysql();
            Navigator.pushNamed(context, 'second', arguments: config);
          });
        });
      });
    });
  }

  void initState() {
    super.initState();
    load();

    //cargamos la configuración de la navegación
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              // Image.asset('assets/img/logo.jpg'),
              child: Image.asset(
                'assets/img/loading.gif',
                fit: BoxFit.cover,
              )),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: MediaQuery.of(context).size.width / 4,
            child: Text(
              cargando,
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 2.2,
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
        fit: StackFit.loose,
      ),
    );
  }
}
