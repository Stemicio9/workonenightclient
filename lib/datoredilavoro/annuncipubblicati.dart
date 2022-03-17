


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workonenight/costanticomuni/immaginidallarete.dart';
import 'package:workonenight/entityclient/annuncio.dart';
import 'package:workonenight/services/annunciperdatore.dart';
import 'package:workonenight/services/informazioniprofilo.dart';
import 'package:workonenight/services/utenteservice.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/costantitema.dart';

final Color headerdecoration = Color.fromRGBO(82, 178, 254, 1);

class AnnunciPubblicati extends StatefulWidget {
  @override
  AnnunciPubblicatiState createState() {
    return AnnunciPubblicatiState();
  }

}

class AnnunciPubblicatiState extends State<AnnunciPubblicati>{

  Timer timer;

  PageController controller = new PageController();

  List<bool> isSelected = [true,false,false];

  int annunciocorrente = 1;

  // 0 = annunci attivi; 1 = annunci matchati; 2 = storico annunci
  int statoannunciattuale = 0;

  @override
  void initState() {
    super.initState();
    controller = new PageController(viewportFraction: 0.5);
 //   timer = Timer.periodic(Duration(seconds: 60), (timer) { refresh();});
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
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 8,
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
        pulsanteabbonamento("Filtra" , (){}),
      //  Text("Pagina " + controller.page.toString()),
    /*    pulsanteabbonamento("Ricarica" , (){
          refresh();
        }) */
      ],
    );
  }


  Future<void> refresh() async {
    var res = await annunciservice.prendiannunci();
    setState(() {

    });
     return;
  }


  Widget costruiscilista(){
    return StreamBuilder(
      stream: statoannunciattuale == 0 ? annunciservice.mieiannunciattivi.stream.asBroadcastStream() : statoannunciattuale == 1 ? annunciservice.mieiannuncimatchati.stream.asBroadcastStream() : annunciservice.storicoannunci.stream.asBroadcastStream(),
      builder: (context,snapshot){
        if(!snapshot.hasData || snapshot.data == null){
          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(azzurroscuro),),);
        }

        if(snapshot.data.data.length == 0){
          return Center(
            child: Text("NON CI SONO ANNUNCI")
          );
        }
        return PageView.builder(

            pageSnapping: false,
            controller: controller,
            itemBuilder: (context,index) => CardAnnuncio(annuncio: snapshot.data.data[index],
                                                         indice: index,
                                                         totale: snapshot.data.data.length,
                                                         stato: statoannunciattuale,),
            itemCount: snapshot.data.data.length,
            onPageChanged: (numeropaginanuova) {
            //  setState(() {
           //   this.annunciocorrente = numeropaginanuova+1;
           // });
              },
        );
      },
    );
  }




  spostastatoannunci(stato) async {
    var res = await annunciservice.prendiannunci();
    setState(() {
      this.statoannunciattuale = stato;
    });
  }



  Widget parteinferiore(){

   Widget buttons = ButtonGroup(
      titles: ["Attivi", "Accettati", "Storico"],
      current: statoannunciattuale,
      onTab: (selected) {
        print(selected);
        setState(() {
        //  statoannunciattuale = selected;
          spostastatoannunci(selected);
        });
      },
    );

   /*  Widget buttons = ToggleButtons(
      children: <Widget>[
        PulsanteInferiore(testo: "Attivi", icona: Icon(Icons.notifications_active, color: azzurroscuro,), funzione: () {spostastatoannunci(0);}),
        PulsanteInferiore(testo: "Accettati", icona: Icon(Icons.check, color: azzurroscuro), funzione: () {spostastatoannunci(1);}),
        PulsanteInferiore(testo: "Storico", icona: Icon(Icons.list, color: azzurroscuro), funzione: () {spostastatoannunci(2);}),
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
        spostastatoannunci(index);
      },
      isSelected: isSelected,
      borderRadius: BorderRadius.circular(10),


    ); */

 /*    return Stack(
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
     ); */

    return Center(
      child: buttons
    );

  }

}

//


class PulsanteInferiore extends StatelessWidget {

  String testo;
  Icon icona;
  Function funzione;

  PulsanteInferiore({this.testo,this.icona,this.funzione});

  @override
  Widget build(BuildContext context) {
     return
     GestureDetector(
       onTap: (){this.funzione();},
       child: Container(
           padding: EdgeInsets.symmetric(horizontal: 10),
           child:

           Stack(
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
       ),
     );
  }

}



class CardAnnuncio extends StatelessWidget {
  
   Annuncio annuncio;
   int indice;
   int totale;
   int stato;
   
   CardAnnuncio({this.annuncio,this.indice,this.totale,this.stato});
  

  @override
  Widget build(BuildContext context) {


      return

     GestureDetector(
       onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(annuncio: annuncio,stato: stato,)));},
       child:
       Column(
         children: [
           Text((indice+1).toString() + " di " + totale.toString()),
           SizedBox(height: 8,),
           Expanded(
             child: card(annuncio,context)
           )
         ],
       )

     );
  }
//


}



Widget card(Annuncio annuncio ,context){
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    elevation: 10,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(30)), gradient: LinearGradient(colors: [azzurrochiaro,azzurroscuro, azzurroscuro, azzurroscuro])),
          height: 40,
          child: Center(
              child: Text(annuncio.azienda.nomeazienda, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,color: Colors.white))
          ),
        ),


        rigadellacard(annuncio,context)

      ],
    ),
  );
}


Widget rigadellacard(annuncio, context){


  String tag = annuncio.uid;

  String uid = annuncio.pubblicanteid.uid;

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

                          Text(annuncio.mansione != "" ? annuncio.mansione : "Mansione non inserita", style: TextStyle(fontSize: 9),),

                          Container(height: 5,),

                          Hero(
                            tag: tag,
                            child: Container(
                              height: 40, width: 40,
                              decoration:
                              BoxDecoration(
                                  color: azzurroscuro,
                                  // QUI ANDREBBE MESSA L'IMMAGINE DELL'ICONA
                                  image: DecorationImage(
                                      image: immagineprofilodauid(uid),
                                      fit: BoxFit.cover
                                  ),

                              ),
                            ),
                          ),
                          Container(height: 10,),

                          FutureBuilder(
                              future: utenteService.nomeutentedauid(uid),
                              builder: (context,snapshot) {
                                if(!snapshot.hasData){
                                  return CircularProgressIndicator();
                                }
                                return Text(snapshot.data, style: TextStyle(fontSize: 9),);
                              }),

                          Container(height: 5,),

                          Container(
                            height: 60, width: 60,
                            decoration: BoxDecoration(
                                color: azzurroscuro,
                                image: DecorationImage(
                                    image: immagineprofilodauid(uid),
                                    fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(80),
                            ),
                          ),




                        ]
                    )
                )
            )
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
          iconacontitolo(Icon(Icons.timer, size: 22, color: giallo), annuncio.ora.toString() + ":" + annuncio.minuto.toString()),
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


class DetailScreen extends StatelessWidget {

  Annuncio annuncio;
  String herotag;
  int stato;

  DetailScreen({this.annuncio, this.herotag, this.stato});

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
               Expanded(flex: 1, child: Container(height: MediaQuery.of(context).size.width*0.8,child: Text("Informazioni aggiuntive: ",
                   textAlign: TextAlign.center,style: TextStyle(color: Colors.grey, fontSize: 14)),)),
               Expanded(flex: 1, child: Text(annuncio.noteaggiuntive)),

               Expanded(flex: 1,
                   child: entrabutton(annuncio.listacandidati != null ? annuncio.listacandidati.length.toString() + " candidati" : "Nessun candidato",
                       context,
                           (){
                             Navigator.of(context).pushNamed("/listacandidati");
                           })),

               Expanded(flex: 1, child: Container()),
               stato != 2 ? Expanded(flex: 1, child: entrabutton("Cancella annuncio", context, (){})) : Container(),

               Expanded(flex: 1, child: Container()),
             ],
           )
         ],
       ),
     );
  }

}


class ButtonGroup extends StatelessWidget {
  static const double _radius = 10.0;
  static const double _outerPadding = 2.0;

  final int current;
  final List<String> titles;
  final ValueChanged<int> onTab;
  final Color color;
  final Color secondaryColor;

  const ButtonGroup({
    Key key,
    this.titles,
    this.onTab,
    int current,
    Color color,
    Color secondaryColor,
  })  : assert(titles != null),
        current = current ?? 0,
        color = color ?? Colors.blue,
        secondaryColor = secondaryColor ?? Colors.white,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(_radius),
      child: Padding(
        padding: const EdgeInsets.all(_outerPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_radius - _outerPadding),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _buttonList(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buttonList() {
    final buttons = <Widget>[];
    for (int i = 0; i < titles.length; i++) {
      buttons.add(_button(titles[i], i));
      buttons.add(
        VerticalDivider(
          width: 1.0,
          color: (i == current || i + 1 == current) ? color : secondaryColor,
          thickness: 1.5,
          indent: 5.0,
          endIndent: 5.0,
        ),
      );
    }
    buttons.removeLast();
    return buttons;
  }

  Widget _button(String title, int index) {
    if (index == this.current)
      return _activeButton(title);
    else
      return _inActiveButton(title, index);
  }

  Widget _activeButton(String title) => FlatButton(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    disabledColor: secondaryColor,
    disabledTextColor: color,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    child: Text(title),
    onPressed: null,
  );

  Widget _inActiveButton(String title, int index) => FlatButton(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    color: Colors.transparent,
    textColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    ),
    child: Text(title),
    onPressed: () {
      if (onTab != null) onTab(index);
    },
  );
}