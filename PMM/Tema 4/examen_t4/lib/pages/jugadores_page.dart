import 'package:examen_t4/models/jugador_model.dart';
import 'package:examen_t4/services/code_igniter_service.dart';
import 'package:examen_t4/widgets/container_jugador.dart';
import 'package:flutter/material.dart';

class JugadoresPage extends StatefulWidget {
  @override
  _JugadoresPageState createState() => _JugadoresPageState();
}

class _JugadoresPageState extends State<JugadoresPage> {
  @override
  Widget build(BuildContext context) {
    final jugadoresTotal =
        ModalRoute.of(context)!.settings.arguments as dynamic;

    List<Jugador> jugadores = jugadoresTotal['jugadores'];
    List<Jugador> jugadoresMySQL = jugadoresTotal['jugadoresMySQL'];
    jugadores.forEach((jugador) {
      if (jugadoresMySQL.any((element) => element.id == jugador.id)) {
        jugador.favorito = true;
      }
    });

    //vamos a comparar los jugadores de la bd...con los del equipo...

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(40, 40, 40, 0.99),
          title: Text('Jugadores'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: jugadores.length,
            itemBuilder: (context, index) { 
              return ContainerJugador(jugadores[index], (Jugador jugador) {
                setState(() {
                  jugador.favorito = !jugador.favorito!;
                });
              });
            }));
  }
}
