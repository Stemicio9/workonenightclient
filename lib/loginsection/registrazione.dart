
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workonenight/authentication/authservice.dart';
import 'package:workonenight/model/utentecompleto.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/inputs.dart';
import 'package:workonenight/notifichepush/notificationservice.dart';

class Registrati extends StatefulWidget {
  @override
  RegistratiState createState() {
    return RegistratiState();
  }

}


class RegistratiState extends State<Registrati>{

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController nomeutentecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool switchvalue = false;   // false = Lavoratore , true = Datore

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: appbarsenzaactions("Registrazione"),
        body:
        Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  // Add TextFormFields and ElevatedButton here.
                  Padding(padding: EdgeInsets.only(bottom: 20),),
                  InputWidget(labeltext: "Email", hinttext: "email@esempio.com", controller: emailcontroller, ispassword: false ,validator: validaemail),
                  Padding(padding: EdgeInsets.only(bottom: 20),),
                  InputWidget(labeltext: "Password", hinttext: "******", controller: passwordcontroller, ispassword: true ,validator: validapassword),
                  Padding(padding: EdgeInsets.only(bottom: 20),),
                  InputWidget( labeltext: "Nome utente",hinttext: "NickName", controller: nomeutentecontroller, ispassword: false ,validator: defaultvalidator),
                  Padding(padding: EdgeInsets.only(bottom: 20),),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Lavoratore", style: TextStyle(
                          color: !switchvalue ? Colors.green : Colors.black,
                          fontSize: !switchvalue ? 19 : 16
                      ),),
                      Switch(
                        value: switchvalue,
                        onChanged: (value){
                          setState(() {
                            switchvalue=value;
                          });
                        },),
                      Text("Datore di lavoro", style: TextStyle(
                          color: switchvalue ? Colors.green : Colors.black,
                          fontSize: switchvalue ? 19 : 16
                      )),
                    ],
                  ),

                  entrabutton("Registrati", context,registrati),
                ]
            )
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



  registrati() async {
    IdTokenResult token = await loginservice.signup(nomeutentecontroller.text,emailcontroller.text,passwordcontroller.text);
    if(token == null) {
      print("ERRORE NELLA REGISTRAZIONE");
      return;
    }

    FirebaseUser currentuser = await FirebaseAuth.instance.currentUser();
    UtenteCompleto utentecompleto = new UtenteCompleto(uid: currentuser.uid, email: currentuser.email,
        nomeutente: nomeutentecontroller.text, ruolo: switchvalue ? "datore" : "lavoratore",firebasemessagetoken: firebasetoken);
    var response = await loginservice.registrasuserver(utentecompleto);
    UtenteCompleto result = UtenteCompleto.fromJson(response['data']);

    if(result.ruolo == "datore") {
      Navigator.of(context).pushNamed("/dashboarddatore");
    }else {
      Navigator.of(context).pushNamed("/dashboardlavoratore");
    }
  }


}

extension EmailValidator on String {
bool isValidEmail() {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);
}
}
