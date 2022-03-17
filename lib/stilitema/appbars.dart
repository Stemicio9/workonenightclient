


import 'package:flutter/material.dart';
import 'package:workonenight/authentication/authservice.dart';

import 'costantitema.dart';

appbarsenzaactions(String titolo){
  return new AppBar(
     backgroundColor: azzurroscuro,
     title: Text(titolo,style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),),
     centerTitle: true,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.vertical(
         bottom: Radius.circular(30)
       )
     ),
  );
}

appbarconaction(String titolo,context){
  return new AppBar(
    backgroundColor: azzurroscuro,
    title: Text(titolo,style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),),
    centerTitle: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30)
        )
    ),

    actions: [
      IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){loginservice.logout(context);})
    ],

  );
}


