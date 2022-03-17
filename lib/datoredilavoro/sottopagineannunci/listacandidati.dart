

import 'package:flutter/material.dart';
import 'package:workonenight/entityclient/annuncio.dart';
import 'package:workonenight/stilitema/appbars.dart';

class ListaCandidati extends StatefulWidget {

  Annuncio annuncio;

  ListaCandidati({this.annuncio});

  @override
  ListaCandidatiState createState() {
    return ListaCandidatiState();
  }

}

class ListaCandidatiState extends State<ListaCandidati>{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: appbarsenzaactions("Lista candidati"),
       body: Container(),
     );
  }

}