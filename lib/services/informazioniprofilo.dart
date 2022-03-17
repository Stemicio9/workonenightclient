


import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:workonenight/entityclient/azienda.dart';
import 'package:workonenight/entityclient/posizionelatlong.dart';
import 'package:workonenight/entityclient/skill.dart';
import 'package:workonenight/entityclient/utente.dart';



NetworkImage immagineprofilo(){
  return NetworkImage(" ");
}

String emailousername(){
  // @todo
  return dummy();
}

String piccoladescrizionelavoratore(){
  // @todo
  return dummydesc();
}

String status(){
  // @todo
  return dummy();
}

bool valoreprofilo(){
  // @todo
  return dummybool();
}

int numeromatch(){
  // @todo
  return dummynumber();
}

int numerovalutazionipositive(){
  // @todo
  return dummynumber();
}

int numeroblacklists(){
  // @todo
  return dummynumber();
}

int annuncirimastiabbonamento(){
  // @todo
  return dummynumber();
}



DateTime fineabbonamento(){
  // @todo
  return dummydatetime();
}

Azienda getazienda(index){
   return listaaziendedummy[index];
}

Skill getskill(index){
  return listaskillsdummy[index];
}

List<Azienda> getaziende(){
  return listaaziendedummy;
}

bool abbonamentoattivo(){
  return true;
}

String dummy(){
  return "Dummy";
}

String dummydesc(){
  return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin et risus sapien. Aliquam tempus sapien non laoreet posuere." +
          "Fusce dolor nulla, interdum ultricies quam vitae, sagittis interdum enim. Nulla a nunc enim. Vestibulum mollis sodales tincidunt. ";
}

bool dummybool(){
  var random = new Random();
  int val = random.nextInt(1);
  if(val == 0){
    return false;
  }else{
    return true;
  }
}


int dummynumber(){
  var random = new Random();
  return random.nextInt(1000);
}

DateTime dummydatetime(){
  var randomTest = new Random();
  DateTime startDate = DateTime.now();
  Duration duration = Duration(days: randomTest.nextInt(2000));
  startDate.add(duration);
  return startDate;
}

int dummyhour(){
  var randomTest = new Random();
  return randomTest.nextInt(23);
}

int dummyminute(){
  var randomTest = new Random();
  return randomTest.nextInt(59);
}

List<Azienda> listaaziendedummy = [
   new Azienda(nomeazienda: "Azienda 1" , nomelocation: "Via 1", numerocivico: "31" , posizionelatlong:  PosizioneLatLong(latitudine: 35.929673, longitudine: -78.948237)),
   new Azienda(nomeazienda: "Azienda 2" , nomelocation: "Via 2", numerocivico: "31" , posizionelatlong:  PosizioneLatLong(latitudine: 35.929673, longitudine: -78.948237)),
   new Azienda(nomeazienda: "Azienda 3" , nomelocation: "Via 3", numerocivico: "31" , posizionelatlong:  PosizioneLatLong(latitudine: 35.929673, longitudine: -78.948237)),
   new Azienda(nomeazienda: "Azienda 4" , nomelocation: "Via 4", numerocivico: "31" , posizionelatlong:  PosizioneLatLong(latitudine: 35.929673, longitudine: -78.948237)),
   new Azienda(nomeazienda: "Azienda 5" , nomelocation: "Via 5", numerocivico: "31" , posizionelatlong:  PosizioneLatLong(latitudine: 35.929673, longitudine: -78.948237)),
];

List<Skill> listaskillsdummy = [
   new Skill(nomeskill: "Cameriere" , urlimmagine: " "),
   new Skill(nomeskill: "promoter" , urlimmagine: " "),
   new Skill(nomeskill: "Modella" , urlimmagine: " "),
   new Skill(nomeskill: "Barman" , urlimmagine: " "),
];

List<Utente> listautentidummy = [
  new Utente(nomeutente: "GRO"),
  new Utente(nomeutente: "GUE"),
  new Utente(nomeutente: "GILDA"),
  new Utente(nomeutente: "STEFANO"),
  new Utente(nomeutente: "MARIO"),
  new Utente(nomeutente: "IGOR"),
  new Utente(nomeutente: "PIETRO"),
];

List<List<Utente>> listautentiperstream(){
  List<List<Utente>> result = new List();
  result.add(listautentidummy);
  return result;
}

Stream<Utente> streamutenti = Stream.fromIterable(listautentidummy).asBroadcastStream();

FutureOr<List<Utente>> listautentefuture(String stringa){
  return streamutenti.toList();
}

List<dynamic> notifiche = [
  {"titolo" : "Titolo 1" , "letta" : true},
  {"titolo" : "Titolo 2" , "letta" : false},
  {"titolo" : "Titolo 3" , "letta" : false},
  {"titolo" : "Titolo 4" , "letta" : false},
  {"titolo" : "Titolo 5" , "letta" : true},
  {"titolo" : "Titolo 6" , "letta" : true},
  {"titolo" : "Titolo 7" , "letta" : false},
];

List<List<dynamic>> notificheperstream(){
  List<List<dynamic>> result = new List();
  result.add(notifiche);
  return result;
}

Stream<dynamic> streamnotifiche = Stream.fromIterable(notificheperstream()).asBroadcastStream();

List<List<Skill>> listaskillperstream(){
  List<List<Skill>> result = new List();
  result.add(listaskillsdummy);
  return result;
}

FutureOr<List<Skill>> listaskillfuture(String stringa){
  return streamedskillsdummy.toList();
}

Stream<Skill> streamedskillsdummy  = Stream.fromIterable(listaskillsdummy).asBroadcastStream();


const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));