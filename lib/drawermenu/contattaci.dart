

import 'package:flutter/material.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/formcontatti.dart';

class Contattaci extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: appbarsenzaactions("Contattaci"),

       body:
           GestureDetector(
             onTap: (){
               FocusScope.of(context).requestFocus(new FocusNode());
             },
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   SizedBox(height: 15,),
                   Container(
                       width: MediaQuery.of(context).size.width*0.8,
                       child: Text("Per avere più informazioni o per rinnovare il tuo abbonamento contattaci compilando questo form!",
                           textAlign: TextAlign.center,
                           style: TextStyle(color: Colors.grey, fontSize: 14)
                       )
                   ),
                   form(),
                 ],
               ),
             ),
           )


     );
  }

  Widget form(){
    return FormContatti();
  }

}