


import 'package:flutter/material.dart';
import 'package:workonenight/camera/scattafotodafotocamera.dart';
import 'package:workonenight/model/utentecompleto.dart';
import 'package:workonenight/services/utenteservice.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/inputs.dart';

class ModificaProfiloLavoratore extends StatelessWidget {

  TextEditingController nomeutentecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController statuscontroller = new TextEditingController();
  TextEditingController descrizionecontroller = new TextEditingController();
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
               String uid = null;
               if(!snapshot.hasData || snapshot.data == null){

               }else {
                 nomeutentecontroller.text = snapshot.data.nomeutente;
                 statuscontroller.text = snapshot.data.status;
                 numerotelefonocontroller.text = snapshot.data.numerotelefono;
                 descrizionecontroller.text = snapshot.data.descrizione;
                  uid = snapshot.data.uid;
               }

               return Column(
                 children: [
                   Padding(padding: EdgeInsets.only(bottom: 30),),
                   InputWidget(hinttext: "Mario", controller: nomeutentecontroller, labeltext: "Nome utente", keyboard: TextInputType.text,),
                   Padding(padding: EdgeInsets.only(bottom: 10),),
              //     InputWidget(hinttext: "Nuova password", controller: passwordcontroller, labeltext: "Password", keyboard: TextInputType.text,),
              //     Padding(padding: EdgeInsets.only(bottom: 10),),
                   InputWidget(hinttext: "Status", controller: statuscontroller, labeltext: "Status", keyboard: TextInputType.text,),
                   Padding(padding: EdgeInsets.only(bottom: 10),),
                   InputWidget(hinttext: "Descrizione", controller: descrizionecontroller, labeltext: "Descrizione", keyboard: TextInputType.multiline,),
                   Padding(padding: EdgeInsets.only(bottom: 20),),
                   Container(
                     width: MediaQuery.of(context).size.width*0.8,
                     child: Center(
                       child: Text("Il numero di telefono verrà visualizzato soltanto dalle aziende che ti sceglieranno per lavorare!",
                           textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 14)),
                     ),
                   ),
                   Padding(padding: EdgeInsets.only(bottom: 5),),
                   InputWidget(hinttext: "3428023517", controller: numerotelefonocontroller, labeltext: "Numero di telefono", keyboard: TextInputType.text,),
                   Padding(padding: EdgeInsets.only(bottom: 20),),
                   entrabutton("Cambia immagine profilo", context, (){Navigator.of(context).push(new MaterialPageRoute(builder: (context) => TakePictureScreen(camera: cameras.first,)));}),
                   Padding(padding: EdgeInsets.only(bottom: 20),),
                   entrabutton("Modifica", context, (){submit(uid,context);}),
                 ],
               );
             },)
       )

     );
  }


  submit(String uid, context) async{
    if(uid == null) return;
    UtenteCompleto utente = new UtenteCompleto(uid: uid, nomeutente: nomeutentecontroller.text,
        status: statuscontroller.text,
        numerotelefono: numerotelefonocontroller.text,
        descrizione: descrizionecontroller.text);
    utenteService.updateprofilo(utente);
    Navigator.of(context).pop();
  }
  
}