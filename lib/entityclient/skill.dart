
import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';


@JsonSerializable()
class Skill {
  String nomeskill;
  String urlimmagine;


  Skill({this.nomeskill,this.urlimmagine});


/*  Skill.fromJson(Map<String,String> json)
  : nomeskill = json['nomeskill'],
    urlimmagine = json['urlimmagine'];

  Map<String, dynamic> toJson() =>
      {
        'nomeskill' : nomeskill,
        'urlimmagine' : urlimmagine
      };
 */

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);


  factory Skill.fromJsonSoloString(String str){
    return Skill(
      nomeskill : str
    );
  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SkillToJson(this);

  @override
  String toString() {
    return "Nomeskill = " + nomeskill;
  }

}