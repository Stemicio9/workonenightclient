

import 'package:json_annotation/json_annotation.dart';

part 'posizionelatlong.g.dart';


@JsonSerializable()
class PosizioneLatLong {

  double latitudine;
  double longitudine;

  PosizioneLatLong({this.latitudine,this.longitudine});

/*  PosizioneLatLong.fromJson(Map<String, dynamic> json)
  : latitudine = json['latitudine'],
    longitudine = json['longitudine'];

  Map<String,dynamic> toJson() =>
  {
    'latitudine': latitudine,
    'longitudine': longitudine
  }; */

  factory PosizioneLatLong.fromJson(Map<String, dynamic> json) => _$PosizioneLatLongFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PosizioneLatLongToJson(this);

}