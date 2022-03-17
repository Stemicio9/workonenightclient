


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workonenight/entityclient/skill.dart';
import 'package:workonenight/services/annunciperdatore.dart';
import 'package:workonenight/services/informazioniprofilo.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/inputs.dart';


class PaginaRicercaSkill extends StatelessWidget {

 

  TextEditingController skillcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final skillBloc = SkillProvider.of(context);

      return Scaffold(
          appBar: appbarsenzaactions("Mansione"),
          body:
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: InputWidget(controller: skillcontroller, hinttext: "Es. Cameriere", autofocus: true, onchanged: skillBloc.richiedialserver)
              ),

              Flexible(
                child: StreamBuilder(
                  stream: annunciservice.listaskill.stream.asBroadcastStream(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData || snapshot.data == null){
                      return Center(child: Text("Nessun risultato"));
                    }
                    print("LO SNAPSHOT E' ");
                    print(snapshot.data);
                    return ListView.builder(
                         itemCount: snapshot.data.data.length,
                        itemBuilder: (context,index) =>
                          GestureDetector(
                            onTap: (){Navigator.pop(context,Skill(nomeskill: snapshot.data.data[index].nomeskill, urlimmagine: snapshot.data.data[index].urlimmagine));},
                            child: ListTile(leading: CircleAvatar(
                              // @todo
                              child: Container()),
                              title: Text(snapshot.data.data[index].nomeskill),
                            ),
                          )
                        );
                  },
                ),
              )
            ],
          ),
      );
  }

}



class SkillProvider extends InheritedWidget{

  final SkillBloc skillBloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
     return true;
  }

  static SkillBloc of(BuildContext context) => (context.inheritFromWidgetOfExactType(SkillProvider) as SkillProvider).skillBloc;

  SkillProvider({Key key,SkillBloc skillBloc, Widget child})
  : this.skillBloc = skillBloc ?? SkillBloc(),
   super(child: child, key:key);

}







class SkillBloc {


  richiedialserver(query){
    print("CHIAMO IL SERVER con la query " + query);

    cercaskill(query);
  }

  cercaskill(query) async {
    var a = await annunciservice.prendiskill(query);
  }

  SkillBloc(){
   cercaskill("");
  }


}