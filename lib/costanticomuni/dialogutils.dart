
import 'package:flutter/material.dart';

class DialogUtils {
  static Future<bool> displayDialogOKCallBack(
      BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title, ),
          content:  Text(message),
          actions: <Widget>[
            FlatButton(
              child:  Text("Continua"),
              onPressed: () {
                Navigator.of(context).pop(true);
                // true here means you clicked ok
              },
            ),
            FlatButton(
              child:  Text("Non rimuovere"),
              onPressed: () {
                Navigator.of(context).pop(false);
                // true here means you clicked ok
              },
            )
          ],
        );
      },
    );
  }


  static Future<bool> displaydialogsalvafotoprofilo(
      BuildContext context, String title, String message) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title, ),
          content:  Text(message),
          actions: <Widget>[
            FlatButton(
              child:  Text("Salva"),
              onPressed: () {
                Navigator.of(context).pop(true);
                // true here means you clicked ok
              },
            ),
            FlatButton(
              child:  Text("Non salvare"),
              onPressed: () {
                Navigator.of(context).pop(false);
                // true here means you clicked ok
              },
            )
          ],
        );
      },
    );
  }

}