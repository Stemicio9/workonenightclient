


import 'package:flutter/material.dart';
import 'package:workonenight/bloc/skillbloc.dart';
import 'package:workonenight/costanticomuni/dialogutils.dart';
import 'package:workonenight/datoredilavoro/profilo.dart';
import 'package:workonenight/entityclient/skill.dart';
import 'package:workonenight/services/informazioniprofilo.dart';
import 'package:workonenight/services/utenteservice.dart';
import 'package:workonenight/stilitema/costantitema.dart';

class ProfiloLavoratore extends StatefulWidget {
  @override
  ProfiloLavoratoreState createState() {
   return ProfiloLavoratoreState();
  }

}


class ProfiloLavoratoreState extends State<ProfiloLavoratore> {


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
          ParteSuperioreLavoratore(),
          SizedBox(height: 18),

          piccoladescrizione(),

          middlesection(),

          SizedBox(height: 25),
          Divider(height: 8),

          SizedBox(height: 25),

          BottomSection(),
          SizedBox(height: 25),
        ],
      ),
    );
  }


  Widget piccoladescrizione(){
    return Padding(
      padding: EdgeInsets.only(bottom: 20 , left: 40, right: 40),
      child:
      StreamBuilder(
          stream: utenteService.infoutente.stream.asBroadcastStream(),
          builder: (context,snapshot) {
            if (!snapshot.hasData || snapshot.data == null || snapshot.data.descrizione == null ||
                snapshot.data.descrizione == "") {
              return Text("Non hai inserito nessuna descrizione!");
            }
            return Text(snapshot.data.descrizione == "" ? "Non hai inserito nessuna descrizione!" : snapshot.data.descrizione, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),);
          }
      )

    );
  }


  Widget middlesection(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Divider(height: 8),
          ListTile(
              title: Text("Cosa so fare"),
              trailing:
              GestureDetector(
                  onTap: (){
                  //  Navigator.of(context).pushNamed("/aggiungiskill");
                    {
                      vaiaricercaskill(context);
                    }
                  },
                  child: Icon(Icons.add, color: verdepieno)
              )
          ),
          SizedBox(height: 8),

          StreamBuilder(
              stream: utenteService.infoutente.stream.asBroadcastStream(),
              builder: (context,snapshot){

                if(!snapshot.hasData || snapshot.data == null || snapshot.data.listaskill == null){
                  return Text("Non hai inserito mansioni!");
                }

                var listaskill = snapshot.data.listaskill;
                return Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Container(
                    height: 130,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,

                      itemBuilder: (context,index){
                        Skill s = listaskill[index];
                        return Dismissible(
                          key: Key(s.nomeskill),

                          background: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.redAccent
                            ),

                            child: Icon(Icons.delete, size: 65, color: Colors.white,),
                          ),

                          direction: DismissDirection.up,

                          onDismissed: (direction){

                            rimuoviskill(s);

                          },

                          confirmDismiss: (direction) async {
                            String titolo = "Rimuovere " + s.nomeskill + "?";
                            String messaggio = "Sicuro di voler rimuovere?";
                            var result = await DialogUtils.displayDialogOKCallBack(context,titolo,messaggio);
                            return result;
                          },

                          child:  ItemCardSkill(
                            icon: Icons.center_focus_strong,
                            skill: s,
                            settastato: (){settastato();},
                          ),
                        );
                      },
                      itemCount: listaskill.length,
                    ),
                  ),
                );
              }
              )


        ],
      ),
    );
  }

  void vaiaricercaskill(BuildContext context) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SkillProvider(skillBloc: SkillBloc(),child: PaginaRicercaSkill(),)));
    // Aggiungere la skill al profilo
    //@todo
    utenteService.aggiungiskill(result);
    utenteService.me();
  }


  rimuoviskill(Skill skill){
    utenteService.rimuoviskill(skill);
  }

}





class ParteSuperioreLavoratore extends StatelessWidget{


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
                            Navigator.of(context).pushNamed("/modificaprofilolavoratore");
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

                Padding(padding: EdgeInsets.only(bottom: 4)),

                StreamBuilder(
                  stream: utenteService.infoutente.stream.asBroadcastStream(),
                  builder: (context,snapshot) {
                    if(!snapshot.hasData || snapshot.data == null){
                      return Text("...");
                    }
                    return Text(snapshot.data.status != null ? snapshot.data.status : "Status non impostato!",
                        style: TextStyle(fontSize: 12, color: Colors.grey));
                  },
                ),

              ],
            )),


        Padding(
          padding: EdgeInsets.only(left: 15, right: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

              //@todo
              //PARTE RECENSIONI DA RILASCIARE IN UN SECONDO MOMENTO
    /*          Column(
                children: [
                  Text(numeromatch().toString(), style: TextStyle(fontSize: 20),),
                  Text("Match" , style: TextStyle(color: Colors.grey, fontSize: 10))
                ],
              ),

              Column(
                children: [
                  Text(numerovalutazionipositive().toString(), style: TextStyle(fontSize: 20),),
                  Text("Positivi" , style: TextStyle(color: Colors.grey, fontSize: 10))
                ],
              ),

              Column(
                children: [
                  Text(numeroblacklists().toString(), style: TextStyle(fontSize: 20),),
                  Text("Black List" , style: TextStyle(color: Colors.grey, fontSize: 10))
                ],
              ), */

            ],
          ),
        )

      ],
    );



  }

  Widget contenitorevaloreprofilo(){
    if(valoreprofilo()){
      return
        Icon(Icons.thumb_up, size:54, color: azzurroscuro);
    }else{
      return Icon(Icons.thumb_down, size:54, color: Colors.redAccent);
    }
  }

  Widget contenitorevaloreprofilotemporaneo(){
    return Icon(Icons.hourglass_full, size:54, color: verdepieno.withOpacity(0.6));
  }

  Widget contenitoreimmagineprofilo(){

    return GestureDetector(
      onTap: (){},


      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: azzurroscuro,
          image: DecorationImage(
              image: immagineprofilo(),
              fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(80),
        ),
      ),
    );
  }

}


class ItemCardSkill extends StatelessWidget {

  final icon;
  final Skill skill;
  final Function settastato;

  const ItemCardSkill({
    this.icon,
    this.skill,
    this.settastato
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(


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
                      Text(skill.nomeskill,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9), fontSize: 20)),
                      SizedBox(height: 10,)
                    ],
                  )
              )

          ),
        )

    );
  }

}