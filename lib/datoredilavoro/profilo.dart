
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workonenight/costanticomuni/dialogutils.dart';
import 'package:workonenight/costanticomuni/immaginidallarete.dart';
import 'package:workonenight/entityclient/azienda.dart';
import 'package:workonenight/model/recensioniutente.dart';
import 'package:workonenight/services/utenteservice.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/costantitema.dart';


class ProfiloDatore extends StatefulWidget {
  @override
  ProfiloDatoreState createState() {
     return ProfiloDatoreState();
  }

}

class ProfiloDatoreState extends State<ProfiloDatore> {


  settastato(){
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    utenteService.me();
    utenteService.myfeedbacks();
     return Container(
         child: ListView(
           children: [
             ParteSuperiore(),
             SizedBox(height: 18),
             middlesection(),

             SizedBox(height: 25),
             Divider(height: 8),
             AbbonamentoSection(),
             BottomSection(),
             SizedBox(height: 25),
           ],
         ),
       );

  }



  Widget middlesection(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Divider(height: 8),
          ListTile(
              title: Text("Le mie aziende"),
              trailing:
              GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed("/aggiungiazienda");
                  },
                  child: Icon(Icons.add, color: verdepieno)
              )
          ),
          SizedBox(height: 8),

          StreamBuilder(
              stream: utenteService.infoutente.stream.asBroadcastStream(),
              builder: (context,snapshot) {
                if(!snapshot.hasData || snapshot.data == null || snapshot.data.listaaziende == null){
                  return Text("Non hai inserito aziende!");
                }

                var listaaziende = snapshot.data.listaaziende;

                return
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Container(
                      height: 130,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        scrollDirection: Axis.horizontal,

                        itemBuilder: (context,index){
                          Azienda a = listaaziende[index];
                          return
                          Dismissible(
                            key: Key(a.nomeazienda),

                            background: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Colors.redAccent
                              ),

                                child: Icon(Icons.delete, size: 65, color: Colors.white,),
                              ),
                            direction: DismissDirection.up,

                            onDismissed: (direction){

                              rimuoviazienda(a);

                          /*    ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('$item dismissed'))); */
                            },

                            confirmDismiss: (direction) async {
                              String titolo = "Rimuovere " + a.nomeazienda + "?";
                              String messaggio = "Sicuro di voler rimuovere?";
                              var result = await DialogUtils.displayDialogOKCallBack(context,titolo,messaggio);
                              return result;
                            },

                            child:  ItemCard(
                              icon: Icons.local_activity,
                              name: a.nomeazienda,
                              tasks: a.nomelocation != null && a.numerocivico != null ? r""+a.nomelocation + ", " + a.numerocivico : "",
                              azienda: a,
                              settastato: (){settastato();},
                            ),
                          );
                        },
                        itemCount: listaaziende.length,
                      ),
                    ),
                  );
              }
              ),



        ],
      ),
    );
  }



  rimuoviazienda(azienda){
    utenteService.rimuoviazienda(azienda);
  }

}


// PARTE SUPERIORE

class ParteSuperiore extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
     return Column(
       children: [


     Padding(padding: EdgeInsets.only(top: 16, bottom: 32, left: 32, right: 32),
         child: Column(
           children: [

             Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [

                   GestureDetector(
                       onTap: (){
                         Navigator.of(context).pushNamed("/modificaprofilodatore");
                         },
                       child: Icon(Icons.edit, color: azzurroscuro)
                   ),
                 ]
             ),

             Padding(padding: EdgeInsets.only(bottom: 8)),

             ImmagineProfilo(),

             Padding(padding: EdgeInsets.only(bottom: 8)),

             StreamBuilder(
               stream: utenteService.infoutente.stream.asBroadcastStream(),
               builder: (context,snapshot) {
                 if(!snapshot.hasData || snapshot.data == null){
                   return Text("...");
                 }
                 return Text(snapshot.data.nomeutente,
                     style: TextStyle(fontSize: 16));
               },
             ),
          //   Text(emailousername() , style: TextStyle(fontSize: 16),),

             Padding(padding: EdgeInsets.only(bottom: 4)),



             StreamBuilder(
               stream: utenteService.infoutente.stream.asBroadcastStream(),
               builder: (context,snapshot) {
                 if(!snapshot.hasData || snapshot.data == null){
                   return Text("...");
                 }
                 return Text(snapshot.data.status != null ? snapshot.data.status : "Non hai impostato una breve descrizione",
                             style: TextStyle(fontSize: 12, color: Colors.grey));
               },
             ),
        //     Text(status() , style: TextStyle(fontSize: 12, color: Colors.grey)),

           ],
         )),

// PARTE DELLE RECENSIONI PRIMA DELL'AGGIORNAMENTO
     Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Column(
           children: [
             Container(
                 width: 100,
                 height: 100,
                 child: contenitorevaloreprofilotemporaneo()
             )
           ],
         ),
         Container(
           width: 200,
         child: Text("Quando avremo più dati, ti mostreremo tutte le recensioni ricevute!",
             textAlign: TextAlign.center,
             style: TextStyle(color: Colors.grey, fontSize: 14)
         )
         )

       ],
     ),

         //@todo
         //PARTE RECENSIONI DA RILASCIARE IN UN SECONDO MOMENTO
    /*     StreamBuilder(
           stream: utenteService.recensioniutente.stream.asBroadcastStream(),
             builder: (context,snapshot) {
               if(!snapshot.hasData || snapshot.data == null){
                 return Text("...");
               }
               RecensioniUtente recensioni = snapshot.data;
               return Padding(
                 padding: EdgeInsets.only(left: 15, right: 35),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       children: [
                         Container(
                             width: 100,
                             height: 100,
                             child: contenitorevaloreprofilo(recensioni)
                         )
                       ],
                     ),
                     Column(
                       children: [
                         Text(recensioni.match != null ? recensioni.match.toString() : "0", style: TextStyle(fontSize: 20),),
                         Text("Match" , style: TextStyle(color: Colors.grey, fontSize: 10))
                       ],
                     ),

                     Column(
                       children: [
                         Text(recensioni.valutazionipositive != null ? recensioni.valutazionipositive.toString() : "0", style: TextStyle(fontSize: 20),),
                         Text("Positivi" , style: TextStyle(color: Colors.grey, fontSize: 10))
                       ],
                     ),

                     Column(
                       children: [
                         Text(recensioni.blacklist != null ? recensioni.blacklist.toString() : "0", style: TextStyle(fontSize: 20),),
                         Text("Black List" , style: TextStyle(color: Colors.grey, fontSize: 10))
                       ],
                     ),

                   ],
                 ),
               );
             }
         ), */




         ],
        );



  }

  Widget contenitorevaloreprofilo(RecensioniUtente recensioniutente){
    if(calcolavalorerecensioni(recensioniutente) == 0){
      return Icon(Icons.hourglass_full, size:54, color: verdepieno.withOpacity(0.6));
    }else if(calcolavalorerecensioni(recensioniutente) == 1){
      return Icon(Icons.thumb_up, size:54, color: azzurroscuro);
    }else {
      return Icon(Icons.thumb_down, size:54, color: Colors.redAccent);
    }
  }

  Widget contenitorevaloreprofilotemporaneo(){
    return Icon(Icons.hourglass_full, size:54, color: verdepieno.withOpacity(0.6));
  }


  int calcolavalorerecensioni(RecensioniUtente recensioniutente){
    if(recensioniutente.match == 0 || recensioniutente.match == null){
      return 0;
    }else{
      if(recensioniutente.valutazionipositive/recensioniutente.match > 0.5){
        return 1;
      }
      if(recensioniutente.blacklist/recensioniutente.match > 0.5){
        return 2;
      }
      return 0;
    }
  }

  Widget contenitoreimmagineprofilo(){
    var uid;
    utenteService.infoutente.stream.first.then((value) => uid = value.uid);

    print("UID = " + uid.toString());

    return GestureDetector(
      onTap: (){},


      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: azzurroscuro,
          image: DecorationImage(
            image: immagineprofilodauid(uid),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(80),
        ),
      ),
    );
  }

}

// FINE PARTE SUPERIORE

// PARTE MEDIA


class ItemCard extends StatelessWidget {

  final icon;
  final name;
  final tasks;
  final Azienda azienda;
  final Function settastato;
  
  const ItemCard({
   this.icon,
   this.name,
   this.tasks,
   this.azienda,
   this.settastato 
  });

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
       onLongPress: () async {
         
       },
       
       child: Padding(
         padding: EdgeInsets.only(right: 15),
         child: Container(
           height: 150,
           width: 150,
           
           decoration: BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topRight,
               end: Alignment.bottomLeft,
               colors: gradientlistaaziende
             ),
             borderRadius: BorderRadius.all(Radius.circular(15))
           ),
           
           child: Padding(
             padding: EdgeInsets.only(right: 0, top: 20, bottom: 20),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [

                 Icon(icon,color: Colors.white),
                 Spacer(),
                 Text(azienda.nomeazienda,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9), fontSize: 20),),
                 SizedBox(height: 10),
                 Center(
                     child: Text(azienda.nomelocation != null ? azienda.nomelocation : "Indirizzo non disponibile",
                         maxLines: 10,textAlign: TextAlign.center ,style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 10)),
                 ),


               ],
             )
           )
           
         ),
       )
       
     );
  }

}

// FINE PARTE MEDIA

// PARTE INFERIORE

class AbbonamentoSection extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,

         children: [

           SizedBox(width: 10,),
           Column(
             children: [
               StreamBuilder(
                   stream: utenteService.infoutente.stream.asBroadcastStream(),
                   builder: (context,snapshot) {
                     if(!snapshot.hasData || snapshot.data == null){
                       return CircularProgressIndicator();
                     }
                     return Text(convertidata(snapshot.data.fineabbonamento), style: TextStyle(fontSize: 12));
                   }
                   ),

               Text("Scadenza" , style: TextStyle(color: Colors.grey, fontSize: 9)),
             ],
           ),
   /*        Column(
             children: [
               Text(annuncirimastiabbonamento().toString(), style: TextStyle(fontSize: 12)),
               Text("Annunci" , style: TextStyle(color: Colors.grey, fontSize: 9)),
             ],
           ), */

           Center(
             child: pulsanteabbonamento("Rinnova abbonamento", (){Navigator.of(context).pushNamed("/contattaci");}),
           ),
           SizedBox(width: 10,),

         ],

       )
     );
  }

  final dateformat = DateFormat("dd - MM - yyyy");

  String convertidata(DateTime data){
    return dateformat.format(data);
  }

}

class BottomSection extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
     return Container(
       height: 60,
       color: azzurroscuro.withOpacity(0.2),
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 32),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             GestureDetector(
               onTap: (){Navigator.of(context).pushNamed("/comefunziona");},
               child: Text("Aiuto", style: TextStyle(decoration: TextDecoration.underline))
             )
           ],
         )
       )
     );
  }

}

class ImmagineProfilo extends StatefulWidget{
  @override
  ImmagineProfiloState createState() {
     return ImmagineProfiloState();
  }

}

class ImmagineProfiloState extends State<ImmagineProfilo>{

  String uid;

  @override
  void initState() {
    caricauid();
  }

  caricauid() async {
    setState(() {
      this.uid = utenteService.infoutente.stream.value?.uid;
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){caricauid();},


      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: azzurroscuro,
          image: DecorationImage(
              image: immagineprofilodauid(uid),
              fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(80),
        ),
      ),
    );
  }

}