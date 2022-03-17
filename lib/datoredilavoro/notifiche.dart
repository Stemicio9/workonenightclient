

import 'package:flutter/material.dart';
import 'package:workonenight/services/informazioniprofilo.dart';
import 'package:workonenight/stilitema/costantitema.dart';

class NotificheDatore extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    streamnotifiche = Stream.fromIterable(notificheperstream()).asBroadcastStream();
     return Scaffold(
       body: Container(
         child: StreamBuilder(
           stream: streamnotifiche.asBroadcastStream(),
           builder: (context, snapshot) {
             if(!snapshot.hasData){
               return Center(child: Text("NON HAI NESSUNA NOTIFICA"));
             }
             return ListView.builder(
               padding: EdgeInsets.only(top: 5, bottom: 5),
                 itemCount: snapshot.data.length,
                 itemBuilder: (context, index) {
                  return NotificaDatore(notifica: snapshot.data[index]);
                 });
           },
         ),
       ),
     );
  }

}


class NotificaDatore extends StatelessWidget {

  var notifica;

  NotificaDatore({this.notifica});

  @override
  Widget build(BuildContext context) {

    bool notificaletta = notifica["letta"] == true ? true : false;

    return ListTile(
      leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: azzurroscuro,
          image: DecorationImage(image: immagineprofilo()),
          borderRadius: BorderRadius.all(Radius.circular(100))),),
      title: Padding(
        padding: EdgeInsets.only(left: 20),
        child:
            Text(notifica["titolo"]),
      ),
      trailing:  Container(width: 15,child: Center(child: Container(height: 10,width: 10,
        decoration: BoxDecoration(color: !notificaletta ? azzurroscuro : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(100))),),),),
    );
  }

}