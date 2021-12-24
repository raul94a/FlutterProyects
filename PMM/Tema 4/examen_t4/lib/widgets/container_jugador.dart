import 'package:examen_t4/models/jugador_model.dart';
import 'package:examen_t4/services/code_igniter_service.dart';
import 'package:flutter/material.dart';

class ContainerJugador extends StatefulWidget {
  final Jugador jugador;
  final Function(Jugador) toggleFavorito;
  ContainerJugador(this.jugador, this.toggleFavorito);

  @override
  State<ContainerJugador> createState() => _ContainerJugadorState();
}

class _ContainerJugadorState extends State<ContainerJugador> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, 'jugador/detalle',
                arguments: widget.jugador);
          },
          child: _buildListTile()),
    );
  }

  _buildListTile() {
    return ListTile(
      selectedTileColor: Colors.blueGrey,
      tileColor: Color.fromRGBO(30, 30, 30, 0.98),
      leading: CircleAvatar(
        backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        child: Text(
          widget.jugador.nacionalidad!.substring(0, 2).toUpperCase(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      title: Text(
        widget.jugador.nombre!,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        widget.jugador.posicion!,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      //AQUI ES DONDE TENEMOS QUE CAMBIAR SI LO TENEMOS EN FAV
      trailing: IconButton(
          icon: Icon(
            widget.jugador.favorito! ? Icons.favorite : Icons.favorite_border,
            color: Colors.green.shade200,
          ),
          onPressed: widget.jugador.favorito!
              ? () async {
                  await CodeIgniterService.delete(widget.jugador.id!);
                  // setState(() {
                  //   widget.jugador.favorito = !widget.jugador.favorito!;
                  // });
                  widget.toggleFavorito(widget.jugador);
                }
              : () async {
                  await CodeIgniterService.post(widget.jugador);
                  // setState(() {
                  //   widget.jugador.favorito = !widget.jugador.favorito!;
                  // });
                  widget.toggleFavorito(widget.jugador);
                }),
    );
  }
}
