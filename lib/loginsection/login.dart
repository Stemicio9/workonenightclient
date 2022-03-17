

import 'package:flutter/material.dart';
import 'package:workonenight/startup/permissionrequests.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/costantitema.dart';
import 'package:workonenight/stilitema/loginform.dart';

import 'loginbackground/loginbackground.dart';

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<Login> {

  @override
  void initState() {
    richiedituttipermessiiniziali();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
     double height = MediaQuery.of(context).size.height;
     double width = MediaQuery.of(context).size.width;

     return Scaffold(
       resizeToAvoidBottomPadding: false,
       backgroundColor: Colors.white,
       body: GestureDetector(
           behavior: HitTestBehavior.opaque,
         onTap: () {
             FocusScope.of(context).requestFocus(new FocusNode());
         },
         child:
         Stack(
           children: <Widget>[
             Background(),
             loginelements(context),
           ],
         ),
       ),
     );
  }


  Widget loginelements(BuildContext context){
    return
      Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[


        spaziotrawidgetinaltezza(context,20),

                    LoginForm(),


                    spaziotrawidgetinaltezza(context,30),

                     Center(
                        child: GestureDetector(
                            onTap: vaiapaginapassworddimenticata,
                            child: Text("Password dimenticata?",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline
                              ),)
                        )
                    ),


                    spaziotrawidgetinaltezza(context,30),

                    Center(
                            child: Text("Non hai un account?",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,

                              ),)

                    ),

                    entrabutton("Registrati", context, vaiapaginaregistrati),


      ],
    )
      );
  }


  vaiapaginapassworddimenticata(){
    Navigator.of(context).pushNamed("/passworddimenticata");
  }

  vaiapaginaregistrati(){
    Navigator.of(context).pushNamed("/registrati");
  }

}