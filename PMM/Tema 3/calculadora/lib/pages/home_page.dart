import 'package:calculadora/colors/app_background.dart';
import 'package:calculadora/colors/text_color.dart';
import 'package:calculadora/widgets/calculator_row.dart';
import 'package:calculadora/widgets/history_calculation.dart';
import 'package:calculadora/widgets/text_container.dart';
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
  List<String> _historic = [];
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
          ? '$_savedEnteredNumber $_mode $lastOutput = '
          : '$lastOutput $_mode $_savedEnteredNumber = ';
      //reinicio el modo
      _mode = '';
      //reinicio el auxiliar de numero introducido
      _savedEnteredNumber = '';
      _enteredNumber = '';
      //subo la bandera de igual presionado
      _equalPressed = true;
      _historic.add(_history + ' ' + _output);
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
    final appBar = AppBar(
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
    );
    //calculamos
    final appBarHeight = appBar.preferredSize.height;
    final topHeight = MediaQuery.of(context).padding.top;
    final Size screenSize = MediaQuery.of(context).size;

    final double _availableHeight =
        screenSize.height - (topHeight + appBarHeight);
    final double _availableWidth = screenSize.width;
    bool _wideScreen = _availableHeight > 650;
    return Container(
      decoration: AppBackground(lightColor).fondo(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: SizedBox(
            height: _wideScreen ? _availableHeight * 0.90 : _availableHeight,
            child: _wideScreen
                ? _webView(_availableHeight, _availableWidth)
                : _mobileView(_availableHeight, _availableWidth)),
      ),
    );
  }

  Widget _mobileView(double availableHeight, double availableWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextContainer(availableHeight, availableWidth, _output, _enteredNumber,
            _equalPressed, _history),
        //botones de la calculadora
        ..._createCalculatorRows(availableHeight, availableWidth)
      ],
    );
  }

  Widget _webView(double availableHeight, double availableWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _mobileView(availableHeight, availableWidth),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: EdgeInsets.all(30),
            width: availableHeight * 0.50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Historial de operaciones',
                  style: TextStyle(
                      color: TextColor(lightColor).color(), fontSize: 22),
                ),
                _historic.isEmpty
                    ? SizedBox(
                        height: 20,
                        child: Text('Historial Vacio...',
                            style: TextStyle(
                                color: TextColor(lightColor).color())),
                      )
                    : Center(),
                ..._createHistoric(lightColor, availableWidth, _mode)
              ],
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _createHistoric(bool lightColor, double width, String mode) {
    return _historic
        .map((e) => HistoryCalculation(lightColor, e, width))
        .toList();
  }

  List<Widget> _createCalculatorRows(
      double availableHeight, double availableWidth) {
    return rows
        .map((row) => CalculatorRow(
            availableHeight,
            availableWidth,
            row,
            lightColor,
            _concatenateEnteredNumber,
            _setCalculationMode,
            _calculation,
            _reset,
            _eraseDigit,
            _changeSign))
        .toList();
  }
}
