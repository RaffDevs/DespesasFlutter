import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;

  final double value;

  final double percentage;

  ChartBar({ 
    
    required this.label, 
    
    required this.value, 
    
    required this.percentage 
    
  });

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      
      builder: (ctx, constraints) {

        return Column(

          children: [

            FittedBox(
              
              child: Text('${value.toStringAsFixed(2)}')
              
            ),
            
            Container(

              height: constraints.maxHeight * 0.7,

              width: 10,

              child: Stack(

                alignment: Alignment.bottomCenter,

                children: [

                  Container(

                    decoration: BoxDecoration(

                      border: Border.all(

                        color : Colors.grey,

                        width: 1

                      ),

                      color: Color.fromRGBO(220, 220, 220, 1),

                      borderRadius: BorderRadius.circular(5)

                    ),

                  ),

                  FractionallySizedBox(

                    heightFactor: percentage,

                    child: Container(

                      decoration: BoxDecoration(

                        color: Theme.of(context).primaryColor,

                        borderRadius: BorderRadius.circular(5)

                      ),

                    ),

                  )

                ],

              ),

            ),

            SizedBox(height : 5),

            SizedBox(height : 5),

            FittedBox(
              
              child:Text(label.toUpperCase()) ,

            )

          ],

        );

      }
      
    );

  }

}