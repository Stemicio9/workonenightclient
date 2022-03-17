

import 'package:flutter/material.dart';
import 'package:workonenight/authentication/authservice.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/inputs.dart';

class PasswordDimenticata extends StatefulWidget {

  String emailcorrente;

  PasswordDimenticata({this.emailcorrente});

  @override
  PasswordDimenticataState createState() {
    return PasswordDimenticataState();
  }

}

class PasswordDimenticataState extends State<PasswordDimenticata>{

  TextEditingController emailcontroller = new TextEditingController();

  String risposta;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: appbarsenzaactions("Recupera password"),
       body: Column(
         children: <Widget>[
           Padding(
             padding: EdgeInsets.only(bottom: 25),
           ),
           Padding(
             padding: EdgeInsets.only(
               left: MediaQuery.of(context).size.width / 1.5, bottom: 10
             ),
             child: Text("Email",
             style: TextStyle(
               fontSize: 16
             ),),
           ),

           InputWidget(hinttext: "esempio@email.it", controller: emailcontroller, ispassword: false,),

           Padding(
             padding: EdgeInsets.only(bottom: 25),
           ),

           Padding(
             padding: EdgeInsets.symmetric(horizontal: 20),
             child: Center(
               child: risposta != null ?
               Text(risposta, style: TextStyle(
                   fontSize: 16
               ), textAlign: TextAlign.center,) : Container(),
             ),
           ),

           Padding(
             padding: EdgeInsets.only(bottom: 10),
           ),

           entrabutton("Cambia password", context,submit),

         ],
       )
     );
  }



  submit() async{
    String result = await loginservice.resetpassword(emailcontroller.text);
    setState(() {
      risposta = result;
    });
  }

}