

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workonenight/entityclient/annuncio.dart';
import 'package:workonenight/services/annunciperlavoratore.dart';
import 'package:workonenight/services/informazioniprofilo.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/costantitema.dart';

class AnnunciPubblicatiLavoratore extends StatefulWidget {
  @override
  AnnunciPubblicatiLavoratoreState createState() {
    return AnnunciPubblicatiLavoratoreState();
  }

}

class AnnunciPubblicatiLavoratoreState extends State<AnnunciPubblicatiLavoratore>{


  Timer timer;

  PageController controller = new PageController();

  List<bool> isSelected = [true,false,false];

  int annunciocorrente = 1;

  @override
  void initState() {
    super.initState();
    controller = new PageController(viewportFraction: 0.5);
    timer = Timer.periodic(Duration(seconds: 60), (timer) { refresh();});
    refresh();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Stack(
        children: [

          Column(
            children: [

              Expanded(
                flex: 2,
                child: partesuperiore(),
              ),
              Expanded(
                flex: 9,
                child: costruiscilista(),
              ),
              Expanded(
                flex: 4,
                child: parteinferiore(),
              ),


            ],
          ),


        ]



    );
  }


  Widget partesuperiore(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        StreamBuilder(
          stream: annunciservicelavoratore.mieiannunci.stream.asBroadcastStream(),
          builder: (context,snapshot) {

            if(!snapshot.hasData || snapshot.data == null){
              return Text("Cerco...");
            }
            return Text(annunciocorrente.toString() + " / " + snapshot.data.data.length.toString(), style: TextStyle(fontSize: 9));
          },
        ),

        SizedBox(width: 15,),
        pulsanteabbonamento("Filtra" , (){})

      ],
    );
  }


  Future<void> refresh() async {
    setState(() {
      annunciservicelavoratore.prendiannunci();
    });
    return;
  }


  Widget costruiscilista(){
    return StreamBuilder(
      stream: annunciservicelavoratore.mieiannunci.stream.asBroadcastStream(),
      builder: (context,snapshot){
        if(!snapshot.hasData || snapshot.data == null){
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(azzurroscuro),),);
        }
        return PageView.builder(

          pageSnapping: false,
          controller: controller,
          itemBuilder: (context,index) => CardAnnuncioLavoratore(annuncio: snapshot.data.data[index]),
          itemCount: snapshot.data.data.length,
          onPageChanged: (numeropaginanuova) {setState(() {
            this.annunciocorrente = numeropaginanuova+1;
          });},
        );
      },
    );
  }


  Widget parteinferiore(){


    Widget buttons = ToggleButtons(
      children: <Widget>[
        PulsanteInferioreLavoratore(testo: "Ricerca", icona: Icon(Icons.notifications_active, color: azzurroscuro,),),
        PulsanteInferioreLavoratore(testo: "Accettati", icona: Icon(Icons.check, color: azzurroscuro),),
        PulsanteInferioreLavoratore(testo: "Storico", icona: Icon(Icons.list, color: azzurroscuro),),
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: isSelected,
      borderRadius: BorderRadius.circular(10),


    );

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: buttons,
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        )
      ],
    );

  }

}


class PulsanteInferioreLavoratore extends StatelessWidget {

  String testo;
  Icon icona;

  PulsanteInferioreLavoratore({this.testo,this.icona});

  @override
  Widget build(BuildContext context) {
    return
      Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: icona
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(testo, style: TextStyle(color: azzurroscuro, fontWeight: FontWeight.w700),),
                  ),
                ],
              )
            ],
          )
      );
  }

}



class CardAnnuncioLavoratore extends StatelessWidget {

  Annuncio annuncio;

  CardAnnuncioLavoratore({this.annuncio});


  @override
  Widget build(BuildContext context) {


    return

      GestureDetector(
          onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreenLavoratore(annuncio: annuncio)));},
          child: card(annuncio, context)

      );
  }
//


}



Widget card(Annuncio annuncio, context){
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    elevation: 10,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(30)), gradient: LinearGradient(colors: [azzurrochiaro,azzurroscuro, azzurroscuro, azzurroscuro])),
          height: 40,
          child: Center(
              child: Text(annuncio.azienda.nomeazienda, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,color: Colors.white))
          ),
        ),


        rigadellacard(annuncio,context)

      ],
    ),
  );
}


Widget rigadellacard(annuncio, context){
  String tag = getRandomString(10);

  return
    Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 7,
              child: colonnasinistrabody(context, annuncio),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 150,
                child: VerticalDivider(color: Colors.blueGrey, indent: 0, width: 2,),
              ),),


            Expanded(
                flex: 9,
                child:
                Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text(annuncio.skill.nomeskill, style: TextStyle(fontSize: 9)),

                          Container(height: 5,),

                          Hero(
                            tag: tag,
                            child: Container(height: 40, width: 40, decoration: BoxDecoration(color: azzurroscuro,image: DecorationImage(image: immagineprofilo())),),
                          ),
                          Container(height: 30,),

                          Text(annuncio.pubblicante.nomeutente, style: TextStyle(fontSize: 9)),

                          Container(height: 5,),

                          Container(height: 60, width: 60, decoration: BoxDecoration(color: azzurroscuro,image: DecorationImage(image: immagineprofilo())),),




                        ]
                    )
                )
            ),

          ],
        )
      ],
    );
}

Widget colonnasinistrabody(context, annuncio){
  return Container(
      child: Column(
        children: [
          iconacontitolo(Icon(Icons.today, size: 22, color: giallo), annuncio.data.day.toString() + "/" + annuncio.data.month.toString()),
          iconacontitolo(Icon(Icons.location_on, size: 22, color: giallo), annuncio.distanza),
          iconacontitolo(Icon(Icons.timer, size: 22, color: giallo), annuncio.ora.format(context)),
          iconacontitolo(Icon(Icons.euro_symbol, size: 22, color: giallo), annuncio.paga != null ? annuncio.paga.toString() : "NS"),
        ],
      )
  );
}

Widget iconacontitolo(Icon icon, String testo){
  return Padding(
    padding: EdgeInsets.only(top:5, bottom: 5),
    child: Column(
      children: [
        icon,
        SizedBox(width: 3,),
        RichText(textAlign: TextAlign.left, text: TextSpan(text: testo,style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color:
        azzurroscuro)),)
      ],
    ),
  );
}


class DetailScreenLavoratore extends StatelessWidget {

  Annuncio annuncio;
  String herotag;

  DetailScreenLavoratore({this.annuncio, this.herotag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarsenzaactions(annuncio.azienda.nomeazienda),
      body: Stack(
        children: [
          Column(
            children: [

              Expanded(flex: 1, child: Container()),

              Expanded(
                  flex: 5,
                  child:
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: rigadellacard(annuncio,context),
                  )

              ),

              Expanded(flex: 1, child: Container()),
              Expanded(flex: 1, child: Text(annuncio.noteaggiuntive)),

              Expanded(flex: 1, child: entrabutton(annuncio.listacandidati.length.toString() + " candidati", context, (){})),

              Expanded(flex: 1, child: Container()),
              Expanded(flex: 1, child: entrabutton("Cancella annuncio", context, (){})),

              Expanded(flex: 1, child: Container()),
            ],
          )
        ],
      ),
    );
  }

}
