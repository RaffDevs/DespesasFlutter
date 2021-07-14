import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting('pt_BR', null);

    return transactions.isEmpty ? LayoutBuilder(
      
      builder : (ctx, constraints) {

        return Column (

          children: [

            Container(

              margin: EdgeInsets.symmetric(

                vertical: 20

              ),

              child: Text(

                'Nenhuma transação cadastrada!',

                style: Theme.of(context).textTheme.headline6,

              ),

            ),

            Container(

              height : MediaQuery.of(context).size.height * 0.4,

              child : Image.asset(
              
                'assets/images/sad.png',

                fit: BoxFit.cover,
              
              )

            )

          ],

        );

      }
      
    ) : ListView.builder(

      itemCount: transactions.length,

      itemBuilder: (ctx, index) {

        final trans = transactions[index];

        return Card(

          elevation: 5,

          margin: EdgeInsets.symmetric(

            vertical: 5,

            horizontal: 5

          ),

          child: ListTile(

            leading: CircleAvatar(

              radius: 30,

              child: Padding(

                padding: const EdgeInsets.all(6.0),

                child: FittedBox(
                  
                  child: Text('R\$${trans.value}')
                  
                ),

              ),

            ),

            title: Text(

              trans.title,

              style: Theme.of(context).textTheme.headline6,

            ),

            subtitle: Text(

              DateFormat('d MMM y', 'pt_BR').format(trans.date)

            ),

            trailing: IconButton(

              icon: Icon(Icons.delete),

              color: Theme.of(context).errorColor,

              onPressed: () => onRemove(trans.id),

            ),

          ),
        );

      }

    );
  }

}