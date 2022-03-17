


import 'package:flutter/material.dart';
import 'package:workonenight/authentication/authservice.dart';

NetworkImage immagineprofilodauid(String uid){
  print("UID = " + uid);
  return NetworkImage(baseurl+"users/immagineprofilo/"+uid);
}

Image immaginecomeimmagineprofilo(String uid){
  return Image.network(baseurl+"users/immagineprofilo/"+uid);
}

