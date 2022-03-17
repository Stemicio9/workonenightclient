
import 'package:flutter/material.dart';

import 'buttons.dart';
import 'inputs.dart';

class FormContatti extends StatefulWidget{
  @override
  FormContattiState createState() {
    return FormContattiState();
  }

}

class FormContattiState extends State<FormContatti>{


  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

  TextEditingController _richiestaTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              Padding(padding: EdgeInsets.only(bottom: 20),),
              InputWidget(hinttext: "email@esempio.com", controller: _emailTextController, ispassword: false ,validator: validaemail, labeltext: "Email",),
              Padding(padding: EdgeInsets.only(bottom: 20),),
              InputWidget(hinttext: "Nome e Cognome", controller: _passwordTextController, ispassword: true ,validator: defaultvalidator, labeltext: "Nome e Cognome",),
              Padding(padding: EdgeInsets.only(bottom: 20),),
              InputWidget(hinttext: "Vorrei info su...", controller: _richiestaTextController, ispassword: false ,validator: defaultvalidator, labeltext: "Di cosa hai bisogno?",),
              Padding(padding: EdgeInsets.only(bottom: 20),),
              entrabutton("Invia",context,formsubmit),
            ]
        )
    );
  }



  String validaemail (String value) {
    if (value.isEmpty) {
      return 'Inserire username';
    }
    if(!value.isValidEmail()){
      return "Inserire un indirizzo email valido";
    }
    return null;
  }


  String validapassword (String value) {
    if (value.isEmpty) {
      return 'Inserire una password';
    }
    return null;
  }


  formsubmit () {
    //@todo
    // INVIA IL CONTATTO SULLA MAIL DI W1N
    Navigator.of(context).pushNamed('/dashboarddatore');
  }

}

extension EmailValidator on String {
bool isValidEmail() {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);
}
}
