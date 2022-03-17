
import 'package:json_annotation/json_annotation.dart';

part 'utente.g.dart';


@JsonSerializable()
class Utente {

   String uid;
   String email;
   String ruolo;
   String nomeutente;
   String status;
   String descrizione;
   DateTime fineabbonamento;

  Utente({this.uid,this.email,this.ruolo,this.nomeutente,this.status,this.descrizione,this.fineabbonamento});

/*  Utente.fromJson(Map<String,String> json)
      :    uid = json['uid'],
           email = json['email'],
           ruolo = json['ruolo'],
           nomeutente = json['nomeutente'],
           status = json['status'],
           descrizione = json['descrizione'],
           fineabbonamento = json['fineabbonamento'] == null ? null : DateTime.parse(json['fineabbonamento']);

   Map<String, dynamic> toJson() =>
       {
         'uid' : uid,
         'email' : email,
         'ruolo' : ruolo,
         'nomeutente' : nomeutente,
         'status' : status,
         'descrizione' : descrizione,
         'fineabbonamento' : fineabbonamento.toIso8601String()
       }; */


  factory Utente.fromJson(Map<String, dynamic> json) => _$UtenteFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UtenteToJson(this);

  @override
  String toString() {
     return "Email " + email;

  }

}