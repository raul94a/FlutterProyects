import 'package:examen_t4/models/jugador_model.dart';
import 'package:examen_t4/services/code_igniter_service.dart';
import 'package:examen_t4/widgets/container_jugador.dart';
import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  void _changeFavStatus(Jugador jugador) {
    setState(() {
      jugador.favorito = !jugador.favorito!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: CodeIgniterService.get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return (snapshot.data as List).isEmpty
                    ? const Center(
                        child: Text(
                          'No hay jugadores favoritos',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : _JugadoresFav(
                        favs: snapshot.data, statusHandler: _changeFavStatus);
              }
            }));
  }
}

class _JugadoresFav extends StatelessWidget {
  final List<Jugador> favs;
  Function(Jugador) statusHandler;
  _JugadoresFav({required this.favs, required this.statusHandler});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: (favs).length,
        itemBuilder: (context, index) {
          return ContainerJugador((favs)[index], statusHandler);
        });
  }
}
