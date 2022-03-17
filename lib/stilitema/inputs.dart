


import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {

  final double round = 30.0;
  final String hinttext;
  final String labeltext;
  TextEditingController controller;
  Function validator;
  Function onchanged;
  bool ispassword = false;
  bool autofocus;
  TextInputType keyboard;
  bool enabled = true;


  InputWidget({@required hinttext,@required controller, this.ispassword = false ,validator = defaultvalidator, this.labeltext = "", this.onchanged = funzionecostante, this.autofocus = false, this.keyboard = TextInputType.text, this.enabled })
  : this.hinttext = hinttext,
    this.controller = controller,
    this.validator = validator;

  @override
  Widget build(BuildContext context) {

    final node = FocusScope.of(context);

      return
        Center(
        child: Container(
            width: MediaQuery.of(context).size.width - 60,
            child: Material(
              elevation: 10,
              color: Colors.white,
       /*       shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(round)),
              ), */
              child: Padding(
                padding: EdgeInsets.only(left: 40,right: 20,top: 1, bottom: 1),
                child: TextFormField(
                  validator: this.validator != null ? this.validator : defaultvalidator,
                  obscureText: this.ispassword,
                  onChanged: onchanged,
                  controller: controller,
                  keyboardType: keyboard,
                  onEditingComplete: () => node.nextFocus(),
                  enabled: this.enabled,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hinttext,
                    labelText: labeltext
                  ),
                ),
              ),
            ),
          )
        );
  }





}


class InputWidgetSenzaFocus extends StatelessWidget {

  final double round = 30.0;
  final String hinttext;
  final String labeltext;
  TextEditingController controller;
  Function validator;
  Function onchanged;
  bool ispassword = false;
  bool autofocus;
  TextInputType keyboard;

  InputWidgetSenzaFocus({@required hinttext,@required controller, this.ispassword = false ,validator = defaultvalidator, this.labeltext = "", this.onchanged = funzionecostante, this.autofocus = false, this.keyboard = TextInputType.text })
      : this.hinttext = hinttext,
        this.controller = controller,
        this.validator = validator;

  @override
  Widget build(BuildContext context) {


    return
      Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 60,
            child: Material(
              elevation: 10,
              color: Colors.white,
              /*       shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(round)),
              ), */
              child: Padding(
                padding: EdgeInsets.only(left: 40,right: 20,top: 1, bottom: 1),
                child: TextFormField(
                  validator: this.validator != null ? this.validator : defaultvalidator,
                  obscureText: this.ispassword,
                  onChanged: onchanged,
                  controller: controller,
                  keyboardType: keyboard,

                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hinttext,
                      labelText: labeltext
                  ),
                ),
              ),
            ),
          )
      );
  }





}



void funzionecostante(String into){}

String defaultvalidator (String text) {
  return "";
}

String defaultvalidatornonvuoto(String text){
  if(text.isEmpty){
    return "Inserire un valore!";
  }
  return "";
}