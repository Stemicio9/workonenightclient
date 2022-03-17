
import 'package:workonenight/entityclient/azienda.dart';
import 'package:workonenight/entityclient/skill.dart';
import 'package:workonenight/entityclient/utente.dart';

class UtenteCompleto {


   String uid;
   String email;
   String ruolo;
   String nomeutente;
   String descrizione;
   String status;
   String firebasemessagetoken;
   String numerotelefono;
   DateTime fineabbonamento;
   List<Azienda> listaaziende;
   List<Skill> listaskill;


   UtenteCompleto({this.uid, this.email, this.ruolo, this.nomeutente, this.status, this.numerotelefono ,this.fineabbonamento, this.descrizione, this.firebasemessagetoken, this.listaaziende, this.listaskill});

   UtenteCompleto.fromJson(Map<String, dynamic> json)
       : uid = json['uid'],
         email = json['email'],
         ruolo = json['ruolo'],
         nomeutente = json['nomeutente'],
         descrizione = json['descrizione'],
         status = json['status'],
         firebasemessagetoken = json['firebasemessagetoken'],
         numerotelefono = json['numerotelefono'],
         fineabbonamento = json['fineabbonamento'] == null ? null : DateTime.parse(json['fineabbonamento'] as String),
         listaaziende = (json['listaaziende'] as List)
       ?.map((e) => e == null ? null : Azienda.fromJson(e as Map<String, dynamic>))?.toList(),
         listaskill = (json['listaskill'] as List)
             ?.map((e) => e == null ? null : Skill.fromJsonSoloString(e))?.toList();

   Map<String, dynamic> toJson() =>
       {
         'uid': uid,
         'email': email,
         'ruolo': ruolo,
         'nomeutente': nomeutente,
         'descrizione': descrizione,
         'status': status,
         'firebasemessagetoken': firebasemessagetoken,
         'numerotelefono' : numerotelefono,
         'fineabbonamento': this.fineabbonamento != null ? fineabbonamento.toIso8601String() : null,
         'listaaziende' : this.listaaziende,
         'listaskill' : this.listaskill
       };


   Utente parteutente(){
     Utente result = new Utente();
     result.uid = uid;
     return result;
   }


}