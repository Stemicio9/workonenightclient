
class RecensioniUtente {
  String uid;
  int match;
  int valutazionipositive;
  int blacklist;

  RecensioniUtente({this.uid,this.match,this.valutazionipositive,this.blacklist});

  RecensioniUtente.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        match = json['match'],
        valutazionipositive = json['valutazionipositive'],
        blacklist = json['blacklist'];

  Map<String, dynamic> toJson() =>
      {
        'uid': uid,
        'match': match,
        'valutazionipositive': valutazionipositive,
        'blacklist': blacklist
      };
}