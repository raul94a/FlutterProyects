import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as formatter;

class InputsPage extends StatefulWidget {
  const InputsPage({Key? key}) : super(key: key);

  @override
  State<InputsPage> createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  @override
  String nombre = '';
  void captureName(value) {
    setState(() {
      nombre = value;
    });
  }

  TextEditingController ctFecha = TextEditingController();
  String fecha = '';
  void captureFecha(value) {
    setState(() {
      fecha = formatter.DateFormat('dd/MM/yyyy').format(value).toString();
      ctFecha.text = fecha;
      print(ctFecha.text);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('hola')),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            margin: EdgeInsets.only(top: 25),
            child: Column(
              children: [
                InputNombre(captureName),
                InputFecha(ctFecha, captureFecha)
              ],
            ),
          ),
        ));
  }
}

class InputNombre extends StatelessWidget {
  Function(String) captureName;
  InputNombre(this.captureName);
  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (value) {
          captureName(value);
        },
        decoration: inputDecoration());
  }

  InputDecoration inputDecoration() => InputDecoration(
        icon: Icon(Icons.near_me),
        hintText: 'Nombre',
        hintStyle: TextStyle(color: Colors.red, letterSpacing: 3),
        label: Text('Nombre'),
        contentPadding: EdgeInsets.all(20),
        prefixIcon: Icon(Icons.dangerous),
        suffixIcon: MaterialButton(
          onPressed: () => print(9),
          child: Icon(Icons.search),
        ),
        counterText: 'Contratexto',
        border: OutlineInputBorder(
            gapPadding: 8,
            borderRadius: formBorderRadius(),
            borderSide: BorderSide(width: 3, color: Colors.red)),
      );

  BorderRadius formBorderRadius() => const BorderRadius.only(
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
      topLeft: Radius.circular(5),
      bottomLeft: Radius.circular(5));
}

class InputFecha extends StatelessWidget {
  Function(Object) ctFechaHandler;
  TextEditingController ctFecha = TextEditingController();
  InputFecha(this.ctFecha, this.ctFechaHandler);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctFecha,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        selectDate(context);
      },
    );
  }

  selectDate(BuildContext context) async {
    DateTime dt = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2022))
        .then((value) => value!);

    ctFechaHandler(dt);
  }
}
