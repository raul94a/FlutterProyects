import 'package:examen_t4/models/jugador_model.dart';
import 'package:examen_t4/services/code_igniter_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class JugadorDetallePage extends StatefulWidget {
  @override
  _JugadorDetallePageState createState() => _JugadorDetallePageState();
}

class _JugadorDetallePageState extends State<JugadorDetallePage> {
  String _comentario = '';
  @override
  Widget build(BuildContext context) {
    final jugador = ModalRoute.of(context)!.settings.arguments as Jugador;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(40, 40, 40, 0.99),
          title: Text(jugador.nombre as String),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildImagen(),
              _buildContainerInformacion(jugador),
              _buildSwitch(jugador),
              _buildTextfieldComentario(jugador),
              _buildBotonesFlotantes(jugador),
            ],
          ),
        ));
  }

  Widget _buildTextfieldComentario(Jugador jugador) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(2),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        readOnly: !jugador.favorito!,
        cursorColor: Colors.pink,
        style: const TextStyle(fontSize: 20, color: Colors.grey),
        maxLines: 10,
        onChanged: (value) {
          setState(() {
            _comentario = value;
            jugador.comentario = _comentario;
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          hintText: jugador.comentario!,
          hintStyle: const TextStyle(color: Colors.grey),
          // errorText: 'Algún dato es incorrecto',
          fillColor: const Color.fromRGBO(25, 25, 25, 1),
          filled: true,
        ),
      ),
    );
  }

  Widget _buildBotonesFlotantes(Jugador jugador) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          backgroundColor: Colors.green.shade200,
          onPressed: () => Navigator.pushReplacementNamed(context, 'main'),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 100,
        ),
        FloatingActionButton(
          backgroundColor: Colors.green.shade200,
          onPressed: () async {
            //vamos a hacer una cosita...
            final List<Jugador> jugadoresMySQL = await CodeIgniterService.get();
            if (jugadoresMySQL
                .any((jugadorMySQL) => jugadorMySQL.id == jugador.id)) {
              //lanzamos PUT, ya que el registro EXISTE
              await CodeIgniterService.put(jugador);
            } else {
              //LANZAMOS EL POST!
              await CodeIgniterService.post(jugador);
              //actualizamos el estado del jugador... se redibuja el widget...
              setState(() {});
              jugador.favorito = !jugador.favorito!;
            }
          },
          child: const Icon(
            Icons.save,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget _buildRowInformacion(String elemento, String str) {
    return Row(
      children: [
        Text(
          "$elemento: ",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          str,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget _buildContainerInformacion(Jugador jugador) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black), color: Colors.grey),
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            jugador.nombre as String,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          )),
          const SizedBox(height: 15),
          _buildRowInformacion("Posición", jugador.posicion as String),
          _buildRowInformacion(
              "Pais de nacimiento", jugador.paisNacimiento as String),
          _buildRowInformacion("Nacionalidad", jugador.nacionalidad as String),
          _buildRowInformacion(
              "Nacimiento",
              //la liberia intl es facil de usar para parsear fechas!
              intl.DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(jugador.fechaNacimiento as String))),
        ],
      ),
    );
  }

  Widget _buildImagen() {
    return const Center(
      child: FadeInImage(
        placeholder: AssetImage('assets/loading2.gif'),
        image: NetworkImage(
            'https://www.faq-mac.com/wp-content/uploads/2009/10/25050_640.jpg'),
      ),
    );
  }

  Widget _buildSwitch(Jugador jugador) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Favorito',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Switch(
            inactiveThumbColor: Colors.grey,
            activeColor: Colors.green,
            inactiveTrackColor: Colors.grey,
            value: jugador.favorito!,
            onChanged: (value) async {
              if (jugador.favorito!) {
                //en el caso de qeu el jugador sea favorito en ese momento, se borra de la bd
                await CodeIgniterService.delete(jugador.id!);
              } else {
                //en el caso de que el jugador no sea favorito, se añade a la bd haciéndolo fav
                await CodeIgniterService.post(jugador);
              }
              setState(() {});
              jugador.favorito = !jugador.favorito!;
            }),
      ],
    );
  }
}
