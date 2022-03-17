

import 'package:flutter/material.dart';
import 'package:workonenight/appstate/constants.dart';
import 'package:workonenight/bloc/skillbloc.dart';
import 'package:workonenight/entityclient/annuncio.dart';
import 'package:workonenight/entityclient/azienda.dart';
import 'package:workonenight/entityclient/skill.dart';
import 'package:workonenight/model/utentecompleto.dart';
import 'package:workonenight/services/annunciperdatore.dart';
import 'package:workonenight/services/informazioniprofilo.dart';
import 'package:workonenight/services/utenteservice.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/inputs.dart';

class PubblicaAnnuncio extends StatefulWidget {
  @override
  PubblicaAnnuncioState createState() {
    return PubblicaAnnuncioState();
  }

}

class PubblicaAnnuncioState extends State<PubblicaAnnuncio>{

  TextEditingController mansionecontroller = new TextEditingController();
  String urlmansione;

  TextEditingController datecontroller = new TextEditingController();
  TextEditingController oracontroller = new TextEditingController();
  TextEditingController pagacontroller = new TextEditingController();
  TextEditingController noteaggiuntivecontroller = new TextEditingController();

  Azienda aziendascelta;

  DateTime dataselezionata = DateTime.now();
  TimeOfDay oraselezionata = TimeOfDay.now();

  final ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {

    utenteService.me();

       return
         abbonamentoattivo() ?

         GestureDetector(
             behavior: HitTestBehavior.opaque,
             onTap: () {
               FocusScope.of(context).requestFocus(new FocusNode());
             },
             child:
             Scaffold(
               body: SingleChildScrollView(
                 controller: _scrollController,
                 child: Column(
                 //  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(padding: EdgeInsets.only(bottom: 25),),
                     Hero(child: GestureDetector(
                       onTap: (){vaiaricercaskill(context);},
                       child: AbsorbPointer(child: InputWidget(hinttext: "Es. Cameriere", controller: mansionecontroller,labeltext: "Mansione ricercata",),),
                     ),
                     tag: "Mansione",
                     ),
                     Padding(padding: EdgeInsets.only(bottom: 25),),
                     sceltaazienda(),
                     Padding(padding: EdgeInsets.only(bottom: 25),),
                     GestureDetector(
                       onTap: ()async{selezionadata();},
                     child:
                     AbsorbPointer(child: InputWidget(hinttext: "20/12/1990", controller: datecontroller, labeltext: "Data",))
                     ),
                     Padding(padding: EdgeInsets.only(bottom: 25),),
                     GestureDetector(
                         onTap: ()async{selezionaora();},
                         child:
                         AbsorbPointer(child: InputWidget(hinttext: "18:55", controller: oracontroller, labeltext: "Ora",))
                     ),
                     Padding(padding: EdgeInsets.only(bottom: 25),),
                     InputWidget(hinttext: "80", controller: pagacontroller, labeltext: "Paga", keyboard: TextInputType.number,),
                     Padding(padding: EdgeInsets.only(bottom: 25),),
                     InputWidget(hinttext: "Maglietta blu elettrica", controller: noteaggiuntivecontroller, labeltext: "Note aggiuntive", keyboard: TextInputType.multiline,),
                     Padding(padding: EdgeInsets.only(bottom: 25),),
                     entrabutton("Pubblica",context, (){
                       pubblicaannuncio();
                     }),
                     Padding(padding: EdgeInsets.only(bottom: 25),),

                   ],
                 ),
               ),
             )
         )
             :
             Scaffold(
               body: Center(
                 child: Container(
                   child: Text("Abbonamento scaduto"),
                 ),
               ),
             );
  }

  pubblicaannuncio() async{
    Annuncio dapubblicare = new Annuncio();
    dapubblicare.noteaggiuntive = this.noteaggiuntivecontroller.text;
    dapubblicare.paga = double.parse(this.pagacontroller.text);
    dapubblicare.data = this.dataselezionata;
    dapubblicare.ora = this.oraselezionata.hour;
    dapubblicare.minuto = this.oraselezionata.minute;
    dapubblicare.mansione = this.mansionecontroller.text;
    dapubblicare.datapubblicazione = DateTime.now();
    // Non serve inserire qua il pubblicante, lo faccio direttamente sul server
//    dapubblicare.pubblicante = (await utenteService.infoutente.stream.asBroadcastStream().first).parteutente();

    dapubblicare.azienda = this.aziendascelta;

    if(this.aziendascelta == null){
      UtenteCompleto u = await utenteService.infoutente.first;
      dapubblicare.azienda = u.listaaziende.first;
    }

    bool result = await annunciservice.pubblicaannuncio(dapubblicare);

    if(result){
      final snackBar = SnackBar(content: Text('Annuncio pubblicato!'));
      Scaffold.of(context).showSnackBar(snackBar);
      resettatutto(context);
      // Ritorno in top alla pagina
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    }else{
      print("ANNUNCIO NON PUBBLICATO");
    }
  }

  resettatutto(context){
    this.datecontroller.clear();
    this.oracontroller.clear();
    this.pagacontroller.clear();
    this.noteaggiuntivecontroller.clear();
    this.mansionecontroller.clear();

    this.aziendascelta = new Azienda();

    this.dataselezionata = DateTime.now();
    this.oraselezionata = TimeOfDay.now();
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  Future<DateTime> selezionadata() async {
    DateTime date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2101));
    if(date != null){
      dataselezionata = date;
      datecontroller.text = dateformat.format(date);
    }
  }

  Future<TimeOfDay> selezionaora() async {
     TimeOfDay time = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
     if(time != null){
       oraselezionata = time;
       oracontroller.text = time.format(context);
     }
  }

  void vaiaricercaskill(BuildContext context) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SkillProvider(skillBloc: SkillBloc(),child: PaginaRicercaSkill(),)));
    mansionecontroller.text = result.nomeskill;
    urlmansione = result.urlimmagine;
  }

  Widget sceltaazienda(){

    return StreamBuilder(
        stream : utenteService.infoutente.stream.asBroadcastStream(),
        builder: (context,snapshot) {

          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }

          if(snapshot.data.listaaziende.length == 0){
            return Column(
              children: [
                Text("NON HAI INSERITO AZIENDE"),
                FlatButton(
                    onPressed: (){ Navigator.of(context).pushNamed("/aggiungiazienda");},
                    child: Text("Tocca qui per aggiungere un'azienda!"))
              ]
            );
          }



          return Container(
            width: MediaQuery.of(context).size.width - 60,
            child: Column(children: [
              Center(child:
              Material(
                elevation: 10,
                child: InputDecorator(decoration: InputDecoration(border: InputBorder.none, hintText: "Es. Apple"),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Azienda>(

                      items: snapshot.data.listaaziende.map<DropdownMenuItem<Azienda>>((Azienda valore) {
                        return DropdownMenuItem<Azienda>(
                          value: valore,
                          child: Padding(padding: EdgeInsets.only(left: 40),
                              child:Text(valore.nomeazienda)),
                        );
                      }).toList(),

                      value: this.aziendascelta != null ? this.aziendascelta : snapshot.data.listaaziende[0],

                      onChanged: (Azienda nuovoval) {
                        setState(() {
                        this.aziendascelta = nuovoval;
                      });},

                    ),
                  ),),
              ))
            ],
            ),
          );

        }
    );


  }

}