import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class InputsPage extends StatefulWidget {
  const InputsPage({Key? key}) : super(key: key);

  @override
  _InputsPageState createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  String _nombre = '';
  String _email = '';
  bool showPass = false;
  TextEditingController controladorFecha = TextEditingController();
  String fecha = '';
  List<String> _superpoderes = ['vision', 'volar', 'fuerza', 'salud'];
  String? _superPoder = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inputs'),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: [
            _crearInput(),
            SizedBox(
              height: 5,
            ),
            _crearEmail(),
            SizedBox(
              height: 5,
            ),
            _crearPassword(),
            SizedBox(
              height: 5,
            ),
            _crearPersona(),
            _crearFecha(),
            _crearSelect()
          ],
        ));
  }

  Widget _crearInput() {
    return TextField(
      //autofocus normalmente los queremos desabilitados
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          counter: Text('Letras: ${_nombre.length}'),
          hintText: 'Nombre de usuario',
          labelText: 'Nombre',
          helperText: 'Solo introducir nombre de usuario',
          suffixIcon: const Icon(Icons.accessibility),
          icon: const Icon(Icons.account_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
        print(_nombre);
      },
    );
  }

  Widget _crearEmail() {
    return TextField(
      //autofocus normalmente los queremos desabilitados
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Email del usuario',
          labelText: 'Email',
          suffixIcon: const Icon(Icons.alternate_email),
          icon: const Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (valor) {
        setState(() {
          _email = valor;
        });
        print(_email);
      },
    );
  }

  Widget _crearPassword() {
    return TextField(
      //autofocus normalmente los queremos desabilitados
      obscureText: showPass,
      decoration: InputDecoration(
          hintText: 'Password del usuario',
          labelText: 'password',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPass = showPass ? false : true;
                });
              },
              icon: showPass ? Icon(Icons.lock) : Icon(Icons.lock_open)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
        print(_nombre);
      },
    );
  }

  Widget _crearFecha() {
    return TextField(
      //autofocus normalmente los queremos desabilitados
      enableInteractiveSelection: false,
      controller: controladorFecha,
      decoration: InputDecoration(
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha',
          suffixIcon: Icon(Icons.perm_contact_calendar),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  Widget _crearPersona() {
    return ListTile(
      title: Text('El nombre es: $_nombre'),
      subtitle: Text('Email: $_email'),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? dt = await showDatePicker(
        locale: Locale('es'),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2025));
    if (dt != null) {
      setState(() {
        fecha = intl.DateFormat('dd/MM/yyyy').format(dt);
        controladorFecha.text = fecha;
      });
    }
  }

  List<DropdownMenuItem<String>> _getOpciones() {
    List<DropdownMenuItem<String>> lista = [];
    _superpoderes.forEach((element) {
      lista.add(DropdownMenuItem(child: Text(element), value: element));
    });
    return lista;
  }

  Widget _crearSelect() {
    return DropdownButton(
      hint: Text('hoLA'),
      icon: Icon(Icons.add),
      value: _superpoderes[2],
      items: _getOpciones(),
      onChanged: (valor) {
        setState(() {
          // _superPoder = valor as String;
        });
      },
    );
  }
}
