


import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'azienda.dart';
import 'skill.dart';
import 'utente.dart';



part 'annuncio.g.dart';


@JsonSerializable()
class Annuncio {


  String uid;
  String noteaggiuntive;
  double paga;
  DateTime data;
  int ora;
  int minuto;
  String mansione;
  DateTime datapubblicazione;
  // @todo
  Utente pubblicanteid;
  List<Utente> listacandidati;
  Utente scelto;
  Azienda azienda;
  String distanza;

  Annuncio({this.uid,this.noteaggiuntive,this.paga,this.data,this.ora,this.minuto,this.mansione
    ,this.datapubblicazione,this.pubblicanteid, this.listacandidati,this.scelto, this.azienda,this.distanza});

 /* Annuncio.fromJson(Map<String,String> json)
  : noteaggiuntive = json['noteaggiuntive'],
    paga =int.parse(json['paga']),
    data = json['data'] == null ? null : DateTime.parse(json['data']),
    ora = json['ora'] == null ? null : TimeOfDay.fromDateTime(DateTime.parse(json['data'])),
    skill = Skill.fromJson(json['skill'] as Map),
    datapubblicazione = json['datapubblicazione'] == null ? null : DateTime.parse(json['datapubblicazione']),
    pubblicante = Utente.fromJson(json['pubblicante'] as Map),
    listacandidati = (json['listacandidati'] as List).map((e) => Utente.fromJson(e)).toList(),
    scelto = Utente.fromJson(json['scelto'] as Map),
    azienda = Azienda.fromJson(json['azienda'] as Map),
    distanza = json['distanza'];


  Map<String, dynamic> toJson() =>
      {
        "noteaggiuntive" : noteaggiuntive,
        "paga" : paga,
        "data" : data.toIso8601String(),
        "ora" : ora.toString(),
        "skill" : skill.toJson(),
        "datapubblicazione" : datapubblicazione.toIso8601String(),
        "pubblicante" : pubblicante.to
      } */


  factory Annuncio.fromJson(Map<String, dynamic> json) => _$AnnuncioFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AnnuncioToJson(this);

  @override
  String toString() {
    print("STAMPO L'ANNUNCIO");
     return "ID: " + uid +
    " Note aggiuntive: " +  noteaggiuntive +
    " Data " + data.toString() +
    " Pubblicante " + pubblicanteid?.toString() +
    " Skill " + mansione;
  }

}


