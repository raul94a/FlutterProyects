import 'package:flutter/material.dart';
import 'package:repaso_examen_ii/providers/products_provider.dart';

class AddProductPage extends StatefulWidget {
  final fonts;
  final titles;
  AddProductPage(this.fonts, this.titles);
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String nombre = '';
  double precio = 0;
  TextEditingController controladorNombre = TextEditingController();
  TextEditingController controladorPrecio = TextEditingController();
  List<dynamic> products = [];
  @override
  Widget build(BuildContext context) {
    final usersInfo = ModalRoute.of(context)!.settings.arguments as List;

    // List<String> usersNames() {
    //   List<String> usersName = [];
    //   (usersInfo as List)
    //       .forEach((element) => usersName.add(element['nombre']));
    //   return usersName;
    // }

    // List<String> users = usersNames();

    return Scaffold(
        appBar: AppBar(title: Text(widget.titles[4]['texto']! as String)),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              _inputNombre(),
              SizedBox(
                height: 10,
              ),
              _inputPrecio(),
              SizedBox(
                height: 10,
              ),
              _crearSelect(usersInfo),
              products.isEmpty
                  ? Container()
                  : Container(
                      height: 400,
                      child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 10,
                              child: Column(
                                children: [
                                  Image.network(products[index]['img']),
                                ],
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ));
  }

  Widget _inputNombre() {
    return TextField(
      decoration: InputDecoration(
          hintText: 'Nombre del producto',
          helperText: 'Introduce el nombre del producto',
          labelText: 'Nombre del producto',
          //prefixText: 'Nombre: ',
          suffixIcon: IconButton(
            onPressed: () async {
              List<dynamic> res =
                  await ProductsProvider.searchProductsByName(nombre);
              setState(() {
                products = res;
                
              });
            },
            icon: Icon(Icons.search),
          ),
          prefixIcon: Icon(Icons.precision_manufacturing),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      onChanged: (value) {
        setState(() {
          nombre = value;
          print(nombre);
        });
      },
    );
  }

  Widget _inputPrecio() {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      controller: controladorPrecio,
      decoration: InputDecoration(
          hintText: 'Precio (€)',
          helperText: 'Introduce el precio del producto',
          labelText: 'precio del producto',
          //prefixText: 'Nombre: ',
          suffixIcon: Icon(Icons.add),
          prefixIcon: Icon(Icons.precision_manufacturing),
          border: OutlineInputBorder(
              gapPadding: 5,
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: Colors.red, style: BorderStyle.none))),
      onChanged: (value) {
        setState(() {
          controladorPrecio.text = value;
        });
      },
    );
  }

  List<DropdownMenuItem<String>> _getOpciones(List users) {
    List<DropdownMenuItem<String>> lista = [];
    users.forEach((element) {
      lista.add(DropdownMenuItem(
          child: Text(element['nombre']), value: element['id'].toString()));
    });
    return lista;
  }

  Widget _crearSelect(List users) {
    return DropdownButton(
      value: users[0]['id'].toString(),
      items: _getOpciones(users),
      onChanged: (valor) {
        setState(() {
          print(valor);
        });
      },
    );
  }
}
