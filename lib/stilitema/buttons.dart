



import 'package:flutter/material.dart';

import 'costantitema.dart';



Widget entrabutton(String text, BuildContext context, Function azione){
  return Container(
      width: MediaQuery.of(context).size.width - 60,
      height: 60,
      child:
      Padding(
        padding: EdgeInsets.only( top: 10),
        child: RaisedButton(
          onPressed: azione,
          child:
          Text(text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
        ),
      )
  );
}

Widget pulsanteabbonamento(String testo, Function funzione){
 return
   Container(
     child: MaterialButton(
    color: azzurroscuro,
    elevation: 10,
    onPressed: funzione,

    child: Text(
      testo, style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w700
    ),
    ),
  )
   );
}