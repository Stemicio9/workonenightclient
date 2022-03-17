



import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workonenight/entityclient/annuncio.dart';
import 'package:workonenight/entityclient/azienda.dart';
import 'package:workonenight/entityclient/skill.dart';
import 'package:workonenight/entityclient/utente.dart';

import 'informazioniprofilo.dart';

AnnunciPerLavoratore annunciservicelavoratore = new AnnunciPerLavoratore();

class AnnunciPerLavoratore {

  Dio dio = new Dio();

  final BehaviorSubject<Response> mieiannunci = BehaviorSubject<Response>();


  prendiannunci()async {
    chiamataalserver();
  }

  chiamataalserver(){
    List<Annuncio> lista = crealistadummy();
    //   Stream asstream = Stream.fromIterable(lista);
    Response res = new Response(statusCode: 200, data: lista);
    mieiannunci.sink.add(res);
  }

  List<Annuncio> crealistadummy(){
    List<Annuncio> result = new List();
    var rand = new Random();
    int res = rand.nextInt(15);
    for(var i = 0; i<res; i++){
      result.add(creadummyannuncio());
    }
    return result;
  }


  Annuncio creadummyannuncio(){
    String noteaggiuntive = "Nessuna nota aggiuntiva";
    double paga = dummypaga();
    DateTime data = dummydatetime();
    int ora = dummyhour();
    int minuto = dummyminute();
    Skill skill = new Skill(nomeskill: "Cameriere", urlimmagine: " ");
    Utente pubblicante = new Utente(nomeutente: "Molto");
    List<Utente> candidati = new List();
    Azienda azienda = getazienda(2);
    String distanza = "1 km";
    Annuncio annuncio = new Annuncio(noteaggiuntive: noteaggiuntive,paga: paga, data: data, datapubblicazione: data,ora: ora, minuto: minuto,mansione: "Cameriere",
        pubblicanteid: pubblicante, listacandidati: candidati,azienda: azienda,distanza: distanza);
    return annuncio;
  }


  double dummypaga(){
    var rand = new Random();
    double res = rand.nextDouble();
    return res;
  }


}