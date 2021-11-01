import 'package:flutter/material.dart';
import 'package:gastos_app/models/transaction.dart';
import 'package:intl/intl.dart' as intl;

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  Function(String) deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    //necesito una altura específica para indicarle al listview qué tamaño debe ocupar (si no se lo pongo  no dibuja nada)
    return Container(
      height: 300,
      //este listview es como un column con la funcionalidad e SingleChildScrollView
      //el builder nos permite renderizar elementos de la lista que flutter cargará a medida que vayan apareciendo en el container
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'No hay transacciones aun',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/img/waiting.png',
                    )),
              ],
            )
          : ListView.builder(
              //itemCount ees necesario para indicarle a FLutter cuántos elementos debe pintar
              itemCount: transactions.length,
              //el bulder recibe una funcion itemBuilder, con el context y el indice (permite el acceso). Devuelve un widget
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                              child: Text(
                                  '${transactions[index].amount!.toStringAsFixed(2)}€')),
                        )),
                    title: Text(
                      '${transactions[index].title!}',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    subtitle: Text(
                        '${intl.DateFormat('dd/MM/yyyy').format(transactions[index].date!)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () =>
                          deleteTransaction(transactions[index].id!),
                    ),
                  ),
                );
               /* return Card(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          //PARA ACCEDER A CADA ELEMENTO DE LA LISTA UTILIZAMOS EL INDEX DE LA FUNCIÓN ITEMBUILDER
                          '${transactions[index].amount!.toStringAsFixed(2)} €',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.purple),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        padding: EdgeInsets.all(10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title!,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            intl.DateFormat('dd/MM/yyyy')
                                .format(transactions[index].date!),
                            style: TextStyle(
                                color: Color.fromRGBO(157, 157, 157, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id!),
                        ),
                      ),
                    ],
                  ),
                );*/
              },
            ),
    );
  }
}
