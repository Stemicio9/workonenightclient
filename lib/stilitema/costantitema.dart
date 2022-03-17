


import 'package:flutter/material.dart';

final Color azzurroscuro = Color(0xFF03A0FE);
final Color azzurrochiaro = Color(0xFF0EDED2);
final Color giallo = Color.fromRGBO(254, 167, 10, 1);
final Color verde = Color(0xFF2FE000).withOpacity(0.2);
final Color verdepieno = Color(0xFF2FE000);

Map<int, Color> azzurroscuroformaterial =
{
  50:azzurroscuro.withOpacity(0.1),
  100:azzurroscuro.withOpacity(0.2),
  200:azzurroscuro.withOpacity(0.3),
  300:azzurroscuro.withOpacity(0.4),
  400:azzurroscuro.withOpacity(0.5),
  500:azzurroscuro.withOpacity(0.6),
  600:azzurroscuro.withOpacity(0.7),
  700:azzurroscuro.withOpacity(0.8),
  800:azzurroscuro.withOpacity(0.9),
  900:azzurroscuro,
};

Map<int, Color> gialloformaterial =
{
  50:Color.fromRGBO(254, 167, 10, 0.1),
  100:Color.fromRGBO(254, 167, 10, 0.2),
  200:Color.fromRGBO(254, 167, 10, 0.3),
  300:Color.fromRGBO(254, 167, 10, 0.4),
  400:Color.fromRGBO(254, 167, 10, 0.5),
  500:Color.fromRGBO(254, 167, 10, 0.6),
  600:Color.fromRGBO(254, 167, 10, 0.7),
  700:Color.fromRGBO(254, 167, 10, 0.8),
  800:Color.fromRGBO(254, 167, 10, 0.9),
  900:Color.fromRGBO(254, 167, 10, 1),
};



final List<Color> gradientlistaaziende = [verde, azzurroscuro];

 ThemeData stiletema = new ThemeData(
   brightness: Brightness.light,
   primarySwatch: MaterialColor(0xFF03A0FE, azzurroscuroformaterial),
   visualDensity: VisualDensity.adaptivePlatformDensity,
   colorScheme: ColorScheme(
     primary: azzurroscuro,
     primaryVariant: Colors.red,
     secondary: MaterialColor(giallo.value, gialloformaterial),
     secondaryVariant: Colors.amberAccent,
     surface: Colors.white,
     background: Colors.white,
     error: Colors.red,
     onPrimary: Colors.greenAccent,
     onSecondary: Colors.blue,
     onSurface: Colors.black,
     onBackground: Colors.black,
     onError: Colors.redAccent,
     brightness: Brightness.light
   ),
   buttonTheme: ButtonThemeData(
       buttonColor: Color(0xFF03A0FE),
       textTheme: ButtonTextTheme.primary)
 );


 Widget spaziotrawidget(context, divisorelarghezza){
   return Padding(
     padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/divisorelarghezza),
   );
 }

Widget spaziotrawidgetinaltezza(context, divisorealtezza){
  return Padding(
    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/divisorealtezza),
  );
}

