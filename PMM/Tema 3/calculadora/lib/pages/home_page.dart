import 'package:calculadora/widgets/calculator_row.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = '';
  //String _lastOutput = '';
  String _savedEnteredNumber = '';
  String _enteredNumber = '';
  String _mode = '';
  String _history = '';
  bool _equalPressed = false;

  void _concatenateEnteredNumber(String input) {
    setState(() {
      _equalPressed = false;
      _enteredNumber += input;
    });
  }

  void _setCalculationMode(String mode) {
    setState(() {
      if (_enteredNumber == '' && mode == '-') {
        _equalPressed = false;
        _enteredNumber = mode;
        return;
      }

      _mode = mode;
      if (_enteredNumber == '') return;
      /* if (_output != '') {
        _calculation();
        _enteredNumber = '';
        return;
      }*/

      _savedEnteredNumber = _enteredNumber;
      _enteredNumber = '';
      if (_output == '') {
        _history = '$_savedEnteredNumber $_mode';
      } else {
        _history = '$_output $_mode $_savedEnteredNumber = ';
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

  void _calculation() {
    if (_mode == '') return;
    String lastOutput = _output == '' ? _enteredNumber : _output;

    setState(() {
      switch (_mode) {
        case '+':
          _output = sum(lastOutput, _savedEnteredNumber);
          // print('EN MAS');
          break;
        case '-':
          if (_savedEnteredNumber.startsWith('-')) {
            _mode = '+';
            _output = sum(lastOutput, _savedEnteredNumber);
          } else {
            _output = minus(lastOutput, _savedEnteredNumber);
          }
          break;
        case '*':
          _output = multiply(lastOutput, _savedEnteredNumber);
          break;
        case '/':
          _output = divide(lastOutput, _savedEnteredNumber);
          break;
        default:
          print('HAS ENTRADO EN DEFAULT Y NO DEBERIAS');
          break;
      }

      _history = '$lastOutput $_mode $_savedEnteredNumber = ';
      _mode = '';
      _enteredNumber = '';
      _savedEnteredNumber = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.white,
            margin: const EdgeInsets.all(2),
            child: Column(
              children: [
                Text(_history),
                Text(
                  _equalPressed ? _output : _enteredNumber,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          CalculatorRow(firstRow, _concatenateEnteredNumber,
              _setCalculationMode, _calculation, _reset),
          CalculatorRow(secondRow, _concatenateEnteredNumber,
              _setCalculationMode, _calculation, _reset),
          CalculatorRow(thirdRow, _concatenateEnteredNumber,
              _setCalculationMode, _calculation, _reset),
          CalculatorRow(forthRow, _concatenateEnteredNumber,
              _setCalculationMode, _calculation, _reset),
        ],
      ),
    );
  }
}
