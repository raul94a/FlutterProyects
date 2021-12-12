import 'package:exament3/models/docentes_model.dart';
import 'package:flutter/material.dart';

class DocentesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<DocenteResponse> docentes =
        ModalRoute.of(context)!.settings.arguments as List<DocenteResponse>;

    docentes.sort((a, b) {
      return a.subname
          .toString()
          .toLowerCase()
          .compareTo(b.subname.toString().toLowerCase());
    });
    //print(docentes);
    return Scaffold(
        appBar: AppBar(title: Text('Nuestros Docentes'),backgroundColor: Colors.indigo,),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: docentes
                .map((docente) => Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      width: MediaQuery.of(context).size.width - 5,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.indigo[50],
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        //border: Border.all(color: Colors.black, width: 0)
                      ),
                      child: Row(
                        children: [
                          //foto
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Container(
                              width: 130,
                              height: 150,
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(docente.photo!, scale: 2),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Column(
                                  children: [
                                    Text('${docente.name!} ${docente.subname!}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 25,
                                      child: Text(
                                        docente.email!,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text('Modulo: ${docente.rol!}')
                            ],
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        )));
  }
}
