import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class NewTransaction extends StatefulWidget {
  Function(String, String, DateTime?)? addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _inputTitle = TextEditingController();
  final _inputAmount = TextEditingController();
  DateTime? _selectedDate;

  _addTransaction() {
    widget.addNewTransaction!(
        _inputTitle.text, _inputAmount.text, _selectedDate);
    Navigator.of(context).pop();
  }

  _startDatePicker(context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    label: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    'Título',
                    style: TextStyle(),
                  ),
                )),
                controller: _inputTitle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                decoration: InputDecoration(
                    label: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    'Cantidad',
                    style: TextStyle(),
                  ),
                )),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _inputAmount,
                onSubmitted: (_) {
                  _addTransaction();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  _selectedDate == null
                      ? 'No has elegido fecha!'
                      : '${intl.DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                FlatButton(
                    onPressed: () => _startDatePicker(context),
                    child: Text(
                      'Elige una fecha',
                      style: Theme.of(context).textTheme.button, ////TextStyle(
                      // color: Colors.purple, fontWeight: FontWeight.bold)),
                    )),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.only(right: 8),
              height: 50,
              child: RaisedButton(
                color: Theme.of(context).colorScheme.primary,
                elevation: 6,
                child: Text(
                  'Añadir transacción',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _addTransaction();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
