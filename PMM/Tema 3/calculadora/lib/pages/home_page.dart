import 'package:calculadora/colors/app_background.dart';
import 'package:calculadora/colors/text_color.dart';
import 'package:calculadora/widgets/calculator_row.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = '';
  String _savedEnteredNumber = '';
  String _enteredNumber = '';
  String _mode = '';
  String _history = '';
  bool lightColor = false;
  bool _equalPressed = false;

  void _concatenateEnteredNumber(String input) {
    setState(() {
      _equalPressed = false;
      _enteredNumber += input;
      if (_output != '') {
        _history = '$_output $_mode $_enteredNumber';
      }
    });
  }

  void _setCalculationMode(String mode) {
    if ((_output == '' && _enteredNumber == '') || _enteredNumber == '-')
      return;
    setState(() {
      _mode = mode;
      //En el caso de gestionar el primer cálculo...
      if (_output == '') {
        _savedEnteredNumber = _enteredNumber;
        _enteredNumber = '';
        _history = '$_savedEnteredNumber $_mode';
      } else {
        _history = '$_output $_mode';
      }
    });
  }

  String sum(a, b) {
    return (int.parse(a) + int.parse(b)).toString();
  }

  String minus(a, b) => (int.parse(a) - int.parse(b)).toString();
  String multiply(a, b) => (int.parse(a) * int.parse(b)).toString();
  dynamic divide(a, b) {
    int divisor = int.parse(b);
    if (divisor == 0) {
      return;
    }
    return (int.parse(a) / divisor).toStringAsFixed(0);
  }

  Map<String, String> exchangeValues(String a, String b) {
    return {"last_output": b, "savedEnteredNumber": a};
  }

  String _getOutput(String lastOutput, String savedEnteredNumber, String mode) {
    Map calculationValues = exchangeValues(lastOutput, _savedEnteredNumber);
    print(calculationValues);
    String output = '';
    switch (mode) {
      case "+":
        output = _output == ''
            ? sum(calculationValues["last_output"],
                calculationValues["savedEnteredNumber"])
            : sum(lastOutput, _savedEnteredNumber);
        break;
      case "-":
        output = _output == ''
            ? minus(calculationValues["last_output"],
                calculationValues["savedEnteredNumber"])
            : minus(lastOutput, _savedEnteredNumber);
        break;
      case "*":
        output = _output == ''
            ? multiply(calculationValues["last_output"],
                calculationValues["savedEnteredNumber"])
            : multiply(lastOutput, _savedEnteredNumber);
        break;
      case "/":
        output = _output == ''
            ? divide(calculationValues["last_output"],
                calculationValues["savedEnteredNumber"])
            : divide(lastOutput, _savedEnteredNumber);
        break;
    }

    return output;
  }

  void _eraseDigit() {
    if (_enteredNumber == '') return;
    setState(() {
      _enteredNumber = _enteredNumber.substring(0, _enteredNumber.length - 1);
    });
  }

  void _calculation() {
    bool firstCalculation = false;
    if (_output == '') firstCalculation = true;
    if (_enteredNumber.startsWith('-') && _mode == '') {
      _mode = '+';
    }
    // pulso en el igual sin un modo de operacion, bloqueo la ejecución de la función
    if (_mode == '') return;
    //recogo el SEGUNDO valor introducido (ocurre solo en la primera cuenta) o el valor que llevo acumulado
    String lastOutput = _output == '' ? _enteredNumber : _output;
    //si el output está seteado, es decir, NO es la primera cuenta...
    if (_output != '') {
      _savedEnteredNumber = _enteredNumber;
    }
    //borro el número introducido

    setState(() {
      //obtengo el output calculado
      _output = _getOutput(lastOutput, _savedEnteredNumber, _mode);
      //seteo el historial de cuenta

      _history = firstCalculation
          ? '$_savedEnteredNumber $_mode $lastOutput'
          : '$lastOutput $_mode $_savedEnteredNumber = ';
      //reinicio el modo
      _mode = '';
      //reinicio el auxiliar de numero introducido
      _savedEnteredNumber = '';
      _enteredNumber = '';
      //subo la bandera de igual presionado
      _equalPressed = true;
    });
  }

  void _reset() {
    setState(() {
      _mode = '';
      _enteredNumber = '';
      _output = '';
      _history = '';
      _savedEnteredNumber = '';
      _equalPressed = false;
    });
  }

  void _changeSign() {
    setState(() {
      if (_enteredNumber.startsWith('-'))
        _enteredNumber = _enteredNumber.substring(1);
      else
        _enteredNumber = '-' + _enteredNumber;
      _equalPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBackground(lightColor).fondo(),
      child: Scaffold(
        drawer:
            IconButton(onPressed: () => print('hola'), icon: Icon(Icons.add)),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    lightColor = lightColor ? false : true;
                  });
                },
                iconSize: 40,
                icon: Icon(
                  Icons.colorize,
                  color: TextColor(lightColor).color(),
                ))
          ],
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Calculadora',
            style: TextStyle(color: TextColor(lightColor).color()),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 2),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, Colors.white])),
              width: double.infinity,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _history,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Text(
                      _equalPressed ? _output : _enteredNumber,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            //botones de la calculadora
            ...rows
                .map((row) => CalculatorRow(
                    row,
                    lightColor,
                    _concatenateEnteredNumber,
                    _setCalculationMode,
                    _calculation,
                    _reset,
                    _eraseDigit,
                    _changeSign))
                .toList(),
          ],
        ),
      ),
    );
  }
}
