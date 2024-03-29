

import 'package:flutter/material.dart';
import 'package:workonenight/authentication/authservice.dart';
import 'package:workonenight/services/informazioniprofilo.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/costantitema.dart';

class MenuLaterale extends StatelessWidget {

  List<String> listaelementimenu = new List();


  @override
  Widget build(BuildContext context) {
     return Drawer(
       child: MediaQuery.removePadding(context: context,
           child: Container(
             decoration: BoxDecoration(
            /*   gradient: LinearGradient(
                 begin: Alignment.bottomCenter,
                 end: Alignment.topCenter,
                 colors: [azzurroscuro,azzurrochiaro]
               ) */
              color: azzurroscuro
             ),

             child: Container(child: ListView(children: costruiscilista(context)))

           )),
     );
  }



  costruiscilista(context){
    String v1 = "Policy privacy";
    String v2 = "Come funziona?";
    String v3 = "Contattaci";
    String v4 = "Eventi";
    String v5 = "Logout";

    listaelementimenu.add(v1);
    listaelementimenu.add(v2);
    listaelementimenu.add(v3);
    listaelementimenu.add(v4);
    listaelementimenu.add(v5);

    List<Widget> lista = new List();

    lista.add(
      DrawerHeader(
         decoration: BoxDecoration(color: Colors.white),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: 100,
            width: 100,

            decoration: BoxDecoration(
              color: azzurroscuro,
              image: DecorationImage(image: immagineprofilo(),fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(100))
            ),
          ),
        ),
      )
    );

    lista.add(creatile(v1, (){raccoglitore.policyprivacy(context);}, context, IconData(60223, fontFamily: 'MaterialIcons')));
    lista.add(creatile(v2, (){raccoglitore.comefunziona(context);}, context, IconData(59515, fontFamily: 'MaterialIcons')));
    lista.add(creatile(v3, (){raccoglitore.contattaci(context);}, context, IconData(57529, fontFamily: 'MaterialIcons')));
    lista.add(creatile(v4, (){raccoglitore.eventi();}, context, IconData(59512, fontFamily: 'MaterialIcons'), comingsoon: true));
    lista.add(creatile(v5, (){loginservice.logout(context);}, context, IconData(59513, fontFamily: 'MaterialIcons')));

    listaelementimenu.clear();

    return lista;

  }






  ListTile creatile(String testo, Function funzione, context, IconData icona, {bool comingsoon = false}){
    return new ListTile(
      title: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            Icon(icona,color: Colors.white,),
            SizedBox(width: 15),
            Expanded(child: Text(testo,style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,color: Colors.white))),

            Container(
              child: comingsoon ?
              Container(
                child: Text("Coming Soon", style: TextStyle(fontSize: 13,color: Colors.white, fontWeight: FontWeight.w700)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Colors.purpleAccent
                ),
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              )

                  : Container(),
            )
          ],
        )
      ),
      onTap: funzione,
    );
  }

}


final RaccoglitoreFunzioniNavigazioneMenuLaterale raccoglitore = new RaccoglitoreFunzioniNavigazioneMenuLaterale();


class RaccoglitoreFunzioniNavigazioneMenuLaterale{
  void policyprivacy(context){
    Navigator.of(context).pushNamed("/privacypolicy");
  }

  void comefunziona(context){
    Navigator.of(context).pushNamed("/comefunziona");
  }

  void contattaci(context){
    Navigator.of(context).pushNamed("/contattaci");
  }

  void eventi(){

  }
}