import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../models/transaction.dart';
import './components/transactionForm.dart';
import './components/transactionList.dart';
import './components/chart.dart';


main() => runApp(ExpensesApp());


class ExpensesApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home : HomePage(),

      theme: ThemeData(

        primarySwatch: Colors.purple,

        accentColor: Colors.amber,

        fontFamily: 'Nunito',

        appBarTheme: AppBarTheme(

          textTheme: ThemeData.light().textTheme.copyWith(

            headline6: TextStyle(

              fontFamily: 'Nunito',

              fontSize: 20,

              fontWeight: FontWeight.bold

            )

          )

        )

      ),

      localizationsDelegates: [

        GlobalMaterialLocalizations.delegate,

        GlobalWidgetsLocalizations.delegate
        
      ],

      supportedLocales: [ Locale('pt', 'BR') ],

    );

  }

}


class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  bool showChart = false;

  final List<Transaction> _transaction = [


  ];

  List<Transaction> get _recentTransactions {

    return _transaction.where((transaction) {

      return transaction.date.isAfter(DateTime.now().subtract(

        Duration(days : 7)

      ));

    }).toList();

  }

  _addTransaction(String title, double value, DateTime date) {

    final newTransaction = Transaction(

      id : Random().nextDouble().toString(),

      title: title,

      value : value,

      date : date

    );

    setState(() {
      
      _transaction.add(newTransaction);

    });

    Navigator.of(context).pop();

  }

  _deleteTransaction(String id) {

    setState(() {
      
      _transaction.removeWhere((trans) => trans.id == id);

    });

  }

  _openTransactionFormModal(BuildContext context) {

    showModalBottomSheet(

      context: context,

      builder: (_) {

        return TransactionForm(_addTransaction);

      }

    );

  }

  @override
  Widget build(BuildContext context) {

    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(

      title: Text(
        
        'Despesas Pessoais',

        style: TextStyle(

          fontSize: 20 * MediaQuery.of(context).textScaleFactor

        ),
        
      ),

      actions: [
        
        if (isLandscape)

          IconButton(

            icon: Icon(showChart ? Icons.list : Icons.show_chart_rounded),

            onPressed: () {

              setState(() {
                
                showChart = !showChart;

              });

            },

          ),

        IconButton(

          icon: Icon(Icons.add),

          onPressed: () => _openTransactionFormModal(context),

        ),

        
      ],

    );

    final availableHeight = MediaQuery.of(context).size.height - 
    appBar.preferredSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(

      appBar: appBar,

      body: SingleChildScrollView (

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            if (showChart || !isLandscape) 
            
              Container(

                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                
                child: Chart(_recentTransactions)
              
              ),

            if (!showChart || !isLandscape)

              Column(

                children: [

                  Container(

                    height: availableHeight * 0.7,
                    
                    child: TransactionList(_transaction, _deleteTransaction)
                    
                  ),

                ],

              )
          ],

        ),
      ),

      floatingActionButton: FloatingActionButton(

        child: Icon(Icons.add),

        onPressed: () => _openTransactionFormModal(context)

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );

  }

}