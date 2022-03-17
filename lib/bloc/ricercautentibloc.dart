



import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workonenight/costanticomuni/immaginidallarete.dart';
import 'package:workonenight/entityclient/utente.dart';
import 'package:workonenight/services/informazioniprofilo.dart';
import 'package:workonenight/services/utenteservice.dart';
import 'package:workonenight/stilitema/costantitema.dart';
import 'package:workonenight/stilitema/inputs.dart';

class PaginaRicercaUtenti extends StatelessWidget {


  TextEditingController utenticontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    streamutenti = Stream.fromIterable(listautentidummy).asBroadcastStream();

    final utentebloc = UtentiProvider.of(context);

    return
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
      FocusScope.of(context).requestFocus(new FocusNode());
    },
    child:

      Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 10),),
          Center(child: Text("Ricerca utenti"),),
          Padding(padding: EdgeInsets.only(bottom: 10),),
          Container(
              padding: EdgeInsets.all(10),
              child: InputWidgetSenzaFocus(controller: utenticontroller, hinttext: "Es. Mario", autofocus: true, onchanged: utentebloc.richiedialserver)
          ),

          Padding(padding: EdgeInsets.only(bottom: 10),),
          StreamBuilder(
              stream: utenteService.listautentiricerca.stream.asBroadcastStream(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: Text("Nessun risultato"));
                }
                if(snapshot.data.data.length == 0){
                  return Center(child: Text("Nessun risultato"));
                }



                return
               ListView.builder(
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context,index) {
                    var uid = snapshot.data.data[index].uid;
                      return GestureDetector(
                        onTap: () {},
                        child: ListTile(
                          leading: Container(width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: azzurroscuro,
                                image: DecorationImage(
                                    image: immagineprofilodauid(uid)),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(100))),),
                          title: Text(snapshot.data.data[index].nomeutente),
                        ),
                      );
                    }
                    );

              },
            ),

        ],
      )
      )
    ;
  }

}



class UtentiProvider extends InheritedWidget{

  final UtentiBloc utentebloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static UtentiBloc of(BuildContext context) => (context.inheritFromWidgetOfExactType(UtentiProvider) as UtentiProvider).utentebloc;

  UtentiProvider({Key key,UtentiBloc utentebloc, Widget child})
      : this.utentebloc = utentebloc ?? UtentiBloc(),
        super(child: child, key:key);

}







class UtentiBloc {

  richiedialserver(query){
    print("CHIAMO IL SERVER con la query " + query);

    cercalavoratore(query);
  }

  cercalavoratore(query) async {
    var a = await utenteService.querylavoratori(query);
  }

  SkillBloc(){
    cercalavoratore("");
  }
}