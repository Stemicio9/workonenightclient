
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workonenight/authentication/authservice.dart';
import 'package:http/http.dart' as http;
import 'package:workonenight/entityclient/azienda.dart';
import 'package:workonenight/entityclient/skill.dart';
import 'package:workonenight/model/recensioniutente.dart';
import 'package:workonenight/model/utentecompleto.dart';


UtenteService utenteService = new UtenteService();

class UtenteService {

  Dio dio = new Dio();

  BehaviorSubject<UtenteCompleto> infoutente = BehaviorSubject<UtenteCompleto>();

  BehaviorSubject<RecensioniUtente> recensioniutente = BehaviorSubject<RecensioniUtente>();

  Future aggiungiazienda(Azienda azienda) async {
    Map<String,String> headers = await loginservice.getheader();
    http.Response response = await http.post(baseurl + "users/aggiungiazienda", headers: headers, body: jsonEncode(azienda.toJson()));
    print("RISPOSTA DAL SERVER");
    print(response.body);
    me();
  }

  Future rimuoviazienda(Azienda azienda) async {
    Map<String,String> headers = await loginservice.getheader();
    http.Response response = await http.post(baseurl + "users/rimuoviazienda", headers: headers, body: jsonEncode(azienda.toJson()));
    print("RISPOSTA DAL SERVER");
    print(response.body);
    me();
  }

  Future aggiungiskill(Skill skill) async {
    Map<String,String> headers = await loginservice.getheader();
    http.Response response = await http.get(baseurl + "users/aggiungiskill/"+skill.nomeskill, headers: headers);
    print("RISPOSTA DAL SERVER");
    print(response.body);
    me();
  }

  Future rimuoviskill(Skill skill) async {
    Map<String,String> headers = await loginservice.getheader();
    http.Response response = await http.get(baseurl + "users/rimuoviskill/"+skill.nomeskill, headers: headers);
    print("RISPOSTA DAL SERVER");
    print(response.body);
    me();
  }

  Future me() async {
    Map<String,String> headers = await loginservice.getheader();
    http.Response response = await http.get(baseurl + "users/me", headers: headers);
    var res = UtenteCompleto.fromJson(jsonDecode(response.body));
    print("INFORMAZIONI SULL'UTENTE: ");
    print(response.body);
    infoutente.sink.add(res);
  }

  Future myfeedbacks() async {
    Map<String,String> headers = await loginservice.getheader();
    http.Response response = await http.get(baseurl + "users/myfeedbacks", headers: headers);
    var res = RecensioniUtente.fromJson(jsonDecode(response.body));
    recensioniutente.sink.add(res);
  }

  Future updateprofilo(UtenteCompleto utentecompleto) async {
    Map<String,String> headers = await loginservice.getheader();
    http.Response response = await http.post(baseurl + "users/update", headers: headers, body: jsonEncode(utentecompleto.toJson()));
    var res = UtenteCompleto.fromJson(jsonDecode(response.body));
    infoutente.sink.add(res);
  }


  Future updatefotoprofilo(file) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseurl + "users/salvaimmagineprofilo"));
    Map<String,String> headers = await loginservice.getheader();
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<String> nomeutentedauid(uid) async {
    Map<String,String> headers = await loginservice.getheader();
    http.Response response = await http.get(baseurl + "users/nomeutentedauid/" + uid, headers: headers);
    return response.body;
  }

  BehaviorSubject<Response> listautentiricerca = BehaviorSubject<Response>();

  Future querylavoratori(query) async {
      Map<String, String> headers = await loginservice.getheader();
      http.Response response = await http.post(
          baseurl + "users/querylavoratori/" + query, headers: headers);
      if (response.statusCode == 200) {
        if (response.statusCode != 200) {
          print("RISPOSTA DEL SERVER");
          print(response.body);
        } else {
          print("RISPOSTA DEL SERVER");
          print(response.body);
          Response res = new Response(statusCode: 200, data: parseutente(response.body));
          listautentiricerca.sink.add(res);
        }
      }

  }

  List<UtenteCompleto> parseutente(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<UtenteCompleto>((json) => UtenteCompleto.fromJson(json)).toList();
  }

}