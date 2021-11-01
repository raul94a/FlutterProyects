import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';
import 'package:intl/intl.dart' as intl;

class NewTransaction extends StatefulWidget {
  //Estos <controladors> recogen los datos de los TextField
  Function(Transaction) addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (amountController.text.isEmpty) return;
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    final t = Transaction(
        id: DateTime.now().toString(),
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate);
    widget.addNewTransaction(t);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              //controller nos permite asociar la variable que recogerá los datos del TextField
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'amount'),
              controller: amountController,
              //keyboardType nos permite introducir un tipo de dato especifico, numeros con decimales en este caso
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //onsubmiteed nos permite enviar el formulario dandole al tick del teclado del movil
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate != null
                      ? intl.DateFormat.yMd().format(_selectedDate!)
                      : 'No date chosen!'),
                  FlatButton(
                      onPressed: _presentDatePicker,
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _submitData,
                child: Text('Add transaction'),
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
