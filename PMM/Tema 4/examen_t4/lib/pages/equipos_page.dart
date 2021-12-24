import 'package:examen_t4/models/jugador_model.dart';
import 'package:examen_t4/services/code_igniter_service.dart';
import 'package:examen_t4/services/futbol_service.dart';
import 'package:examen_t4/styles/custom_box_decoration.dart';
import 'package:flutter/material.dart';

class EquiposPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(25, 25, 25, 0.99)),
      child: FutureBuilder(
          future: FutbolService.getEquipos(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Image(image: AssetImage('assets/loading2.gif'));
            } else {
              return _FutureBuilderResultado(snapshot.data as List);
            }
          }),
    );
  }
}

class _FutureBuilderResultado extends StatelessWidget {
  final List equipos;
  _FutureBuilderResultado(this.equipos);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(25),
        itemCount: equipos.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15),
        itemBuilder: (context, index) {
          return _GridViewEquipos(equipos[index]);
        });
  }
}

class _GridViewEquipos extends StatelessWidget {
  final equipo;
  _GridViewEquipos(this.equipo);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        int id = equipo['id'];
        //hacemos la petición de jugadores!
        List<Jugador> jugadores = await FutbolService.getJugadoresEquipo(id);
        List<Jugador> jugadoresMySQL = await CodeIgniterService.get();
        Map<String, dynamic> totalJugadores = {
          "jugadores": jugadores,
          "jugadoresMySQL": jugadoresMySQL
        };
        print(jugadoresMySQL);
        Navigator.pushNamed(context, 'jugadores', arguments: totalJugadores);
      },
      child: Container(
        decoration: customBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.sports_soccer,
              color: Colors.white,
              size: 35,
            ),
            Text(
              equipo['nombre'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

// Widget _buildContainer(int index, BuildContext context) {
//   return InkWell(
//     onTap: () async {
//       int id = equipos[index]['id'];
//       //hacemos la petición de jugadores!
//       List<Jugador> jugadores = await FutbolService.getJugadoresEquipo(id);
//       List<Jugador> jugadoresMySQL = await CodeIgniterService.get();
//       Map<String, dynamic> totalJugadores = {
//         "jugadores": jugadores,
//         "jugadoresMySQL": jugadoresMySQL
//       };
//       print(jugadoresMySQL);
//       Navigator.pushNamed(context, 'jugadores', arguments: totalJugadores);
//     },
//     child: Container(
//       decoration: customBoxDecoration(),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Icon(
//             Icons.sports_soccer,
//             color: Colors.white,
//             size: 35,
//           ),
//           Text(
//             equipos[index]['nombre'] as String,
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           )
//         ],
//       ),
//     ),
//   );
// }
