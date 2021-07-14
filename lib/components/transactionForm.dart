import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class TransactionForm extends StatefulWidget {

  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
  
}

class _TransactionFormState extends State<TransactionForm> {

  final titleController = TextEditingController();

  final valueController = TextEditingController();

  final dateController = TextEditingController();

  late DateTime selectedDate = DateTime.now();


  _submitForm() {

    final title = titleController.text;

    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || selectedDate == null) {

      return;

    }

    widget.onSubmit(title, value, selectedDate);
  }

  _openDatePicker() {

    showDatePicker(

      context : context,

      initialDate : DateTime.now(),

      firstDate : DateTime(2019),

      lastDate : DateTime.now(),

    ).then((date) => {

      if (date != null) {

        setState(() {

          selectedDate = date;

        })

      }

    });

  }

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting('pt_BR', null);

    return Card (

      elevation: 5,

      child: Padding(

        padding: EdgeInsets.all(10),

        child: Column(

          children: [

            TextField(

              controller: titleController,

              onSubmitted: (_) => _submitForm(),

              decoration: InputDecoration(

                labelText: 'Título'

              ),

            ),

            TextField(

              controller: valueController,

              keyboardType: TextInputType.number,

              onSubmitted: (_) => _submitForm(),

              decoration: InputDecoration(

                labelText: 'Valor (R\$)'

              ),

            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Container(

                  child: Row(

                    children: [

                      Text(

                        DateFormat('d/MM/y').format(selectedDate)

                      ),

                      TextButton(

                        child: Text('Selecionar Data'),

                        onPressed: _openDatePicker,

                      ),

                    ],

                  ),

                ),
              
                ElevatedButton(

                  child: Text('Nova Transação'),

                  style: TextButton.styleFrom(

                    primary: Colors.white,

                    backgroundColor: Theme.of(context).primaryColor

                  ),

                  onPressed: _submitForm

                ),

              ],

            ),

          ],

        ),

      )

    );

  }
}