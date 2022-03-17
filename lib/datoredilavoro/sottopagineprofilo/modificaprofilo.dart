

import 'package:flutter/material.dart';
import 'package:workonenight/camera/scattafotodafotocamera.dart';
import 'package:workonenight/model/utentecompleto.dart';
import 'package:workonenight/services/utenteservice.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/inputs.dart';

class ModificaProfilo extends StatelessWidget {

  TextEditingController nomeutentecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController statuscontroller = new TextEditingController();
  TextEditingController numerotelefonocontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: appbarsenzaactions("Modifica"),

      body:

          SingleChildScrollView(
            child:    StreamBuilder(
              stream: utenteService.infoutente.stream.asBroadcastStream(),
              builder: (context,snapshot) {
                if(!snapshot.hasData || snapshot.data == null){
                  return Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 30),),
                      InputWidget(hinttext: "Mario", controller: nomeutentecontroller, labeltext: "Nome utente", keyboard: TextInputType.text,),
                      //          Padding(padding: EdgeInsets.only(bottom: 10),),
                      //          InputWidget(hinttext: "Nuova password", controller: passwordcontroller, labeltext: "Password", keyboard: TextInputType.text,),
                      Padding(padding: EdgeInsets.only(bottom: 20),),
                      InputWidget(hinttext: "Lorem ipsum", controller: statuscontroller, labeltext: "Breve descrizione", keyboard: TextInputType.text,),
                      Padding(padding: EdgeInsets.only(bottom: 20),),
                      Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Center(
                            child: Text("Il numero di telefono verrà visualizzato soltanto dagli utenti scelti per un annuncio!",
                                        textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 14)),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 5),),
                      InputWidget(hinttext: "3428023517", controller: numerotelefonocontroller, labeltext: "Numero di telefono", keyboard: TextInputType.text,),
                      Padding(padding: EdgeInsets.only(bottom: 20),),
                      entrabutton("Cambia immagine profilo", context, (){Navigator.of(context).push(new MaterialPageRoute(builder: (context) => TakePictureScreen(camera: cameras.first,)));}),
                      Padding(padding: EdgeInsets.only(bottom: 20),),
                      entrabutton("Modifica", context, submit),
                    ],
                  );
                }
                nomeutentecontroller.text = snapshot.data.nomeutente;
                statuscontroller.text = snapshot.data.status;
                String uid = snapshot.data.uid;

                return Column(
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 30),),
                    InputWidget(hinttext: "Mario", controller: nomeutentecontroller, labeltext: "Nome utente", keyboard: TextInputType.text,),
                    //           Padding(padding: EdgeInsets.only(bottom: 10),),
                    //           InputWidget(hinttext: "Nuova password", controller: passwordcontroller, labeltext: "Password", keyboard: TextInputType.text,),
                    Padding(padding: EdgeInsets.only(bottom: 20),),
                    InputWidget(hinttext: "Lorem ipsum", controller: statuscontroller, labeltext: "Breve descrizione", keyboard: TextInputType.text,),
                    Padding(padding: EdgeInsets.only(bottom: 20),),
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: Center(
                        child: Text("Il numero di telefono verrà visualizzato soltanto dagli utenti scelti per un annuncio!", textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10),),
                    InputWidget(hinttext: "3428023517", controller: numerotelefonocontroller, labeltext: "Numero di telefono", keyboard: TextInputType.text,),
                    Padding(padding: EdgeInsets.only(bottom: 20),),
                    entrabutton("Cambia immagine profilo", context, (){Navigator.of(context).push(new MaterialPageRoute(builder: (context) => TakePictureScreen(camera: cameras.first,)));}),
                    Padding(padding: EdgeInsets.only(bottom: 20),),
                    entrabutton("Salva", context, (){submit(uid,context);}),
                  ],
                );
              },)
          )


    );
  }


  submit(String uid, context) async {
    UtenteCompleto utente = new UtenteCompleto(uid: uid, nomeutente: nomeutentecontroller.text, status: statuscontroller.text, numerotelefono: numerotelefonocontroller.text);
    utenteService.updateprofilo(utente);
    Navigator.of(context).pop();
  }

}