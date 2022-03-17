


import 'package:json_annotation/json_annotation.dart';

import 'posizionelatlong.dart';


part 'azienda.g.dart';


@JsonSerializable()
class Azienda {

  String uid;
  String nomeazienda;
  String nomelocation;
  String numerocivico;
  PosizioneLatLong posizionelatlong;

  Azienda({this.nomeazienda,this.nomelocation,this.numerocivico,this.posizionelatlong,this.uid});

 /* Azienda.fromJson(Map<String, dynamic> json)
      : nomeazienda= json['nomeazienda'],
        nomelocation = json['nomelocation'],
        numerocivico = json['numerocivico'],
        posizionelatlong = json['posizionelatlong'] == null ? null : PosizioneLatLong.fromJson(json['posizionelatlong']);

  Map<String, dynamic> toJson() =>
      {
        'nomeazienda': nomeazienda,
        'nomelocation': nomelocation,
        'numerocivico': numerocivico,
        'posizionelatlong': posizionelatlong.toJson()
      }; */

  factory Azienda.fromJson(Map<String, dynamic> json) => _$AziendaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AziendaToJson(this);

  @override
  String toString() {
    return this.nomeazienda;
  }

  @override
  bool operator ==(Object other) => other is Azienda && other.nomeazienda == nomeazienda;

  @override
  int get hashCode => nomeazienda.hashCode;
   
}