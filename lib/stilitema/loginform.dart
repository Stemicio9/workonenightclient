


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workonenight/authentication/authservice.dart';
import 'package:workonenight/model/utentecompleto.dart';
import 'package:workonenight/stilitema/inputs.dart';

import 'buttons.dart';

class LoginForm extends StatefulWidget{
  @override
  LoginFormState createState() {
    return LoginFormState();
  }

}

class LoginFormState extends State<LoginForm>{


  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              InputWidget(hinttext: "email@esempio.com", controller: _emailTextController, ispassword: false ,validator: validaemail, labeltext: "Email",),

              InputWidget(hinttext: "password", controller: _passwordTextController, ispassword: true ,validator: validapassword, labeltext: "Password",),

              entrabutton("Entra",context,formsubmit),
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


  formsubmit () async{

    if (_formKey.currentState.validate()) {
      IdTokenResult token = await loginservice.login(_emailTextController.text, _passwordTextController.text);
      print("TOKEN");
      print(token);
      var response = await loginservice.me();
      print("RISPOSTA AL LOGIN");
      print(response);
      UtenteCompleto result = UtenteCompleto.fromJson(response);
      if(result.ruolo == "datore") {
        Navigator.of(context).pushNamed("/dashboarddatore");
      }else {
        Navigator.of(context).pushNamed("/dashboardlavoratore");
      }
    }
  //  Navigator.of(context).pushNamed('/dashboardlavoratore');
  }

}

extension EmailValidator on String {
bool isValidEmail() {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);
  }
}
