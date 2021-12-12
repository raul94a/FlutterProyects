import 'package:calculadora/colors/app_background.dart';
import 'package:calculadora/colors/text_color.dart';
import 'package:calculadora/widgets/calculator_row.dart';
import 'package:calculadora/widgets/history_calculation.dart';
import 'package:calculadora/widgets/operation_historial.dart';
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
    if ((_output == '' && _enteredNumber == '') || _enteredNumber == '-') {
      return;
    }
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
    return (double.parse(a) + double.parse(b)).toString();
  }

  String minus(a, b) => (double.parse(a) - double.parse(b)).toString();
  String multiply(a, b) => (double.parse(a) * double.parse(b)).toString();
  dynamic divide(a, b) {
    double divisor = double.parse(b);
    if (divisor == 0) {
      return;
    }
    return (double.parse(a) / divisor).toStringAsFixed(5);
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
            //en el caso de realizar el PRIMER calculo
            //Juego con tres variables para realizar los cálculos, que son gestionadas
            //de forma diferente en el caso de ser EL PRIMER CALCULO de la calculadora y el resto de cálculos
            //La primera sentencia del ternario solo sirve para que aparezcan los números en el lugar correcto del container de la calculadora
            ? sum(calculationValues["last_output"],
                calculationValues["savedEnteredNumber"])
            //para el resto de calculos
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
    //print(output.split('.'));
   // print(output);
    //print(output.contains('.'));
    final split = output.split('.');

    if (split.length > 1) {
      if (int.parse(output.split('.')[1]) == 0 && output.contains('.')) {
        output = output.split('.')[0];
      }
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
    //recojo el SEGUNDO valor introducido (ocurre solo en la primera cuenta) o el valor que llevo acumulado
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
      _historic = [];
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

  void _resetHistoricHandler() => setState(() => _historic = []);
  //para poner el punto a el valor introducido
  void _intToDouble() {
    if (_enteredNumber.contains('.')) {
      return;
    }
    setState(() {
      _enteredNumber += '.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      toolbarHeight: MediaQuery.of(context).size.width > 650 ? 50 : 50,
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
    bool _wideScreen = _availableWidth > 650;

    return Container(
      decoration: AppBackground(lightColor).fondo(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: SingleChildScrollView(
          child: SizedBox(
              height: _availableHeight,
              child: _wideScreen
                  ? _webView(_availableHeight, _availableWidth)
                  : _mobileView(_availableHeight, _availableWidth)),
        ),
      ),
    );
  }

  Widget _mobileView(double availableHeight, double availableWidth) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextContainer(availableHeight, availableWidth, _output,
              _enteredNumber, _equalPressed, _history),
          //botones de la calculadora
          ..._createCalculatorRows(availableHeight, availableWidth)
        ],
      ),
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
              width: availableHeight * 0.80,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: lightColor ? Colors.black : Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              child: OperationHistorial(lightColor, _historic,
                  _resetHistoricHandler, availableWidth, _mode)),
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
            _changeSign,
            _intToDouble))
        .toList();
  }
}
