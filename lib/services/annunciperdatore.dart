





import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workonenight/authentication/authservice.dart';
import 'package:workonenight/costanticomuni/calcolodistanze.dart';
import 'package:workonenight/entityclient/annuncio.dart';
import 'package:workonenight/entityclient/azienda.dart';
import 'package:workonenight/entityclient/skill.dart';
import 'package:workonenight/entityclient/utente.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as location;

import 'informazioniprofilo.dart';

AnnunciPerDatore annunciservice = new AnnunciPerDatore();

class AnnunciPerDatore {

  Dio dio = new Dio();

  final BehaviorSubject<Response> mieiannunciattivi = BehaviorSubject<Response>();


  final BehaviorSubject<Response> mieiannuncimatchati = BehaviorSubject<Response>();


  final BehaviorSubject<Response> storicoannunci = BehaviorSubject<Response>();



  final BehaviorSubject<Response> listaskill = BehaviorSubject<Response>();


  Future<bool> pubblicaannuncio(Annuncio annuncio) async {
    Map<String, String> headers = await loginservice.getheader();
    http.Response response = await http.post(
        baseurl + "annunci/pubblica", headers: headers, body: jsonEncode(annuncio.toJson()));
    if(response.statusCode == 200){
      print("RESPONSE BODY");
      print(response.body);
        return true;

    }else{
      print("C'è stato un errore nella pubblicazione");
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  prendiannunci() async {
    Map<String, String> headers = await loginservice.getheader();
    http.Response responseattivi = await http.get(
        baseurl + "annunci/mieiannunciattivi", headers: headers);
    http.Response responsematchati = await http.get(
        baseurl + "annunci/mieiannuncimatchati", headers: headers);
    http.Response responsestorico = await http.get(
        baseurl + "annunci/storicoannunci", headers: headers);

    List<Annuncio> attivi = await parseannunci(responseattivi.body);
    Response resattivi = new Response(statusCode: 200, data: attivi);

    List<Annuncio> matchati = await parseannunci(responsematchati.body);
    Response resmatchati = new Response(statusCode: 200, data: matchati);

    List<Annuncio> storico = await parseannunci(responsestorico.body);
    Response resstorico = new Response(statusCode: 200, data: storico);
    mieiannunciattivi.sink.add(resattivi);
    mieiannuncimatchati.sink.add(resmatchati);
    storicoannunci.sink.add(resstorico);
  }

  Future prendiskill(query) async {
    Map<String, String> headers = await loginservice.getheader();
/*    Options opts = new Options();
    opts.headers = headers;
    Response response = await dio.post(baseurl + "annunci/cercaskill",data: jsonEncode(query), options: opts); */
    http.Response response = await http.post(
        baseurl + "annunci/cercaskill/" + query, headers: headers);
    if (response.statusCode == 200) {
      if (response.statusCode != 200) {
        print("RISPOSTA DEL SERVER");
        print(response.body);
      } else {
        print("RISPOSTA DEL SERVER");
        print(response.body);
        Response res = new Response(statusCode: 200, data: parseskill(response.body));
        listaskill.sink.add(res);
      }
    }
  }

  List<Skill> parseskill(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Skill>((json) => Skill.fromJson(json)).toList();
  }

  Future<List<Annuncio>> parseannunci(String responseBody) async {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Annuncio> partialresult =  parsed.map<Annuncio>((json) => Annuncio.fromJson(json)).toList();
    List<Annuncio> result = await inserisciledistanzeinlista(partialresult);
    return result;
  }


  Future<List<Annuncio>> inserisciledistanzeinlista(List<Annuncio> listaannunci) async {
    location.LocationData loc = await getcurrentlocation();
    print("Inserisco le distnze " + loc.toString());
    if(loc == null) return listaannunci;
    for(var curr in listaannunci){
       var distanza = distanzainkm(loc.latitude,loc.longitude,curr.azienda.posizionelatlong.latitudine,curr.azienda.posizionelatlong.longitudine);
       curr.distanza = distanza.toString() + " KM";
    }
    return listaannunci;
  }



  // PER IL LAVORATORE

  final BehaviorSubject<Response> ricercaannuncilavoratore = BehaviorSubject<Response>();


  final BehaviorSubject<Response> mieiannunciattivilavoratore = BehaviorSubject<Response>();


  final BehaviorSubject<Response> storicoannuncilavoratore = BehaviorSubject<Response>();


  prendiannuncilavoratore() async {
    Map<String, String> headers = await loginservice.getheader();
    http.Response responseattivi = await http.get(
        baseurl + "annunci/mieiannunciattivi", headers: headers);
    http.Response responsematchati = await http.get(
        baseurl + "annunci/mieiannuncimatchati", headers: headers);
    http.Response responsestorico = await http.get(
        baseurl + "annunci/storicoannunci", headers: headers);

    List<Annuncio> ricerca = await parseannunci(responseattivi.body);
    Response resricerca = new Response(statusCode: 200, data: ricerca);

    List<Annuncio> attivilav = await parseannunci(responsematchati.body);
    Response resattivilav = new Response(statusCode: 200, data: attivilav);

    List<Annuncio> storico = await parseannunci(responsestorico.body);
    Response resstorico = new Response(statusCode: 200, data: storico);
    ricercaannuncilavoratore.sink.add(resricerca);
    mieiannunciattivilavoratore.sink.add(resattivilav);
    storicoannuncilavoratore.sink.add(resstorico);
  }





  double dummypaga(){
    var rand = new Random();
    double res = rand.nextDouble();
    return res;
  }



  Future<location.LocationData> getcurrentlocation() async{
    location.Location loc = new location.Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await loc.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await loc.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await loc.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await loc.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await loc.getLocation();
    return _locationData;
  }


}