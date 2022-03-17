import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'authentication/authservice.dart';
import 'camera/scattafotodafotocamera.dart';
import 'datoredilavoro/dashboard.dart';
import 'datoredilavoro/sottopagineannunci/listacandidati.dart';
import 'datoredilavoro/sottopagineprofilo/aggiungiazienda.dart';
import 'datoredilavoro/sottopagineprofilo/modificaprofilo.dart';
import 'drawermenu/comefunziona.dart';
import 'drawermenu/contattaci.dart';
import 'drawermenu/privacypolocy.dart';
import 'lavoratore/dashboard_l.dart';
import 'lavoratore/sottopagineprofilo_l/modificaprofilolavoratore.dart';
import 'loginsection/login.dart';
import 'loginsection/passworddimenticata.dart';
import 'loginsection/registrazione.dart';
import 'model/utentecompleto.dart';
import 'stilitema/costantitema.dart';
import 'notifichepush/notificationservice.dart';

String loginiziale;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  var value = await loginservice.me();

  if(value == null || value == "NO"){
    loginiziale = "N";
  }else {
    UtenteCompleto result = UtenteCompleto.fromJson(value);
    loginservice.updatefirebasetoken(firebasetoken);
    if (result.ruolo == "datore") {
      loginiziale = "D";
    } else {
      loginiziale = "L";
    }
  }

  print("LOGIN INIZIALE = " + loginiziale);

  final fotocamere = await availableCameras();
  cameras = fotocamere;

  runApp(WorkOneNightApp());
}

class WorkOneNightApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'W1N',
      theme: stiletema,
   //   home: ScreenController(),
      initialRoute: loginiziale == "N" ? '/login' : loginiziale == "D" ? '/dashboarddatore' : '/dashboardlavoratore',
      routes: routes,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('it')
      ],
    );
  }
}


final routes = {
  '/login' : (context) => Login(),
  '/passworddimenticata' : (context) => PasswordDimenticata(),
  '/registrati' : (context) => Registrati(),
  '/dashboarddatore' : (context) => DashboardDatore(),
  '/dashboardlavoratore' : (context) => DashboardLavoratore(),
  '/listacandidati' : (context) => ListaCandidati(),
  '/privacypolicy' : (context) => PrivacyPolicy(),
  '/comefunziona' : (context) => ComeFunziona(),
  '/contattaci' : (context) => Contattaci(),
  "/modificaprofilodatore" : (context) => ModificaProfilo(),
  "/aggiungiazienda" : (context) => AggiungiAzienda(),
  "/modificaprofilolavoratore" : (context) => ModificaProfiloLavoratore(),
};



class ScreenStateless extends StatelessWidget {


  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


   verificalogin(context) async {
       while(loginiziale == null){

       }
       if(loginiziale == "N"){
         Navigator.of(context).pushNamed("/login");
       }else if(loginiziale == "D"){
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardDatore()));
       }else if (loginiziale == "L"){
         Navigator.of(context).pushNamed("/dashboardlavoratore");
       }
  }


  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    final pushNotificationService = NotifichePushService(_firebaseMessaging);
    pushNotificationService.initialise();

     verificalogin(context);
     return _buildWaitingScreen();
  }

}


class ScreenController extends StatefulWidget {
  @override
  ScreenControllerState createState() => ScreenControllerState();
}


enum AuthState {
  nonloggato,
  datore,
  lavoratore
}

class ScreenControllerState extends State<ScreenController> {

  AuthState stato;

  @override
  void initState() {
    verificalogin();
    super.initState();
  }

  void reassemble() {
    super.reassemble();
  }



   verificalogin() async {

     var value = await loginservice.me();


      if(value == null){
        //return Login();
     /*   setState(() {
          stato = AuthState.nonloggato;
        }); */
        Navigator.of(context).pushNamed("/login");
      }
      UtenteCompleto result = UtenteCompleto.fromJson(value);
      loginservice.updatefirebasetoken(firebasetoken);
      if (result.ruolo == "datore") {
        print("DATORE");
       // return DashboardDatore();
      /*  setState(() {
          stato = AuthState.datore;
        }); */
        Navigator.of(context).pushNamed("/dashboardlavoratore");
      } else {
        print("LAVORATORE");
        Navigator.of(context).pushNamed("/dashboarddatore");
      /*  setState(() {
          stato = AuthState.lavoratore;
        }); */
      }

      reassemble();

  }

  @override
  Widget build(BuildContext context) {
     var state = this.stato;

    switch (state) {
      case AuthState.nonloggato:
        print("FACCIO LO SWITCH");
        Navigator.of(context).pushNamed("/login");
        break;
      case AuthState.datore:
        print("FACCIO LO SWITCH");
        Navigator.of(context).pushNamed("/dashboarddatore");
        break;
      case AuthState.lavoratore:
        print("FACCIO LO SWITCH");
        Navigator.of(context).pushNamed("/dashboardlavoratore");
        break;
    }
    return _buildWaitingScreen();
  }


  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}