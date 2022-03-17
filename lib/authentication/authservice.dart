


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:workonenight/appstate/dashboardpagestate.dart';
import 'package:workonenight/loginsection/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workonenight/model/utentecompleto.dart';
import 'package:workonenight/notifichepush/notificationservice.dart';

// 87.27.62.247

final LoginService loginservice = new LoginService();

final String baseurl = "http://79.61.39.115:8080/";
//final String baseurl = "http://192.168.1.15:8080/";
//final String baseurl = "http://192.168.1.15:8080/";

class LoginService{

  Dio dio = new Dio();


  void logout(context) async {
    await FirebaseAuth.instance.signOut();
    selectedIndex = 3;
    selectedIndexLavoratore = 3;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }

  dynamic datiutente(){

  }


  Future<IdTokenResult> signup(String username, String email, String password) async {
    try {
      AuthResult userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
     IdTokenResult token = await userCredential.user.getIdToken();
     return token;
    } on PlatformException catch (plat){
      if(plat.code == "ERROR_WEAK_PASSWORD"){
        // GESTIRE ECCEZIONE PASSWORD INFERIORE A 6 CARATTERI
        return null;
      }
      if(plat.code == "ERROR_EMAIL_ALREADY_IN_USE"){
        // GESTIRE ECCEZIONE EMAIL GIA' IN USO
        return null;
      }
    //  print(plat.code);   ERROR_WEAK_PASSWORD  ***   ERROR_EMAIL_ALREADY_IN_USE
    } catch (e) {
      print(e);
    }
  }

  Future<IdTokenResult> login(String email, String password) async {
    try {
      AuthResult userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      IdTokenResult token = await userCredential.user.getIdToken();
      updatefirebasetoken(firebasetoken);
      return token;
    } on PlatformException catch (plat){
      if(plat.code == "ERROR_USER_NOT_FOUND"){
        // @todo GESTIRE ECCEZIONE USERNAME NOT FOUND
      }
      if(plat.code == "ERROR_WRONG_PASSWORD"){
        // @todo GESTIRE ECCEZIONE PASSWORD SBAGLIATA
      }
      //  print(plat.code);   ERROR_USER_NOT_FOUND  ***   ERROR_WRONG_PASSWORD
    } catch (e) {
      print(e);
    }
  }


  Future<String> gettoken() async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      if (user == null) return null;
      IdTokenResult result = await user.getIdToken();
      return result.token;
    }catch(e){
      print("ECCEZIONE FIREBASE: ");
      print(e);
      return null;
    }
  }

  Future<String> resetpassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on PlatformException catch(plat){
      print(plat.code);
      if(plat.code == "ERROR_INVALID_EMAIL"){
        return "Indirizzo email non valido";
      }
      if(plat.code == "ERROR_USER_NOT_FOUND"){
        // NON E' STATO TROVATO L'UTENTE
        return "Non è stato trovato nessun utente con l'indirizzo email " + email;
      }
    }catch (e){
      print(e);
    }
    return "E' stata inviata una mail per la reimpostazione della password!";
  }


  Future<Map<String,String>> getheader() async {
    String token = await gettoken();
    if(token == null) return null;
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization" :"Bearer " + token
    };
    return headers;
  }

  Future<dynamic> registrasuserver(UtenteCompleto utenteCompleto) async {
    Map<String,String> headers = await getheader();
    http.Response response = await http.post(baseurl + "users/register", headers: headers, body: jsonEncode(utenteCompleto.toJson()));
    int statusCode = response.statusCode;
    if(statusCode != 200){
      return "Non sono riuscito a prendere i dati dal server";
    }
    return jsonDecode(response.body);
  }

  Future<dynamic> me() async {
    Map<String,String> headers = await getheader();
    if(headers == null) return null;
    print("MI CONNETTO A ");
    print(baseurl);
    http.Response response = await http.get(baseurl + "users/me", headers: headers);
    int statusCode = response.statusCode;
    if(statusCode != 200){
      return "NO";
    }
    return jsonDecode(response.body);
  }

  Future<String> accessSecureResource() async {
    Map<String,String> headers = await getheader();
    http.Response response = await http.get(baseurl+"users/testcontroller", headers: headers);
    int statusCode = response.statusCode;
    if(statusCode != 200){
      return "Could not get input from server";
    }
    return response.body;
  }


  Future updatefirebasetoken(token) async {
    Map<String,String> headers = await getheader();
    http.Response response = await http.post(baseurl+"users/updatemessagetoken", body: token, headers: headers);
    int statusCode = response.statusCode;
    if(statusCode != 200){
      return "Could not get input from server";
    }
    return response.body;
  }

}