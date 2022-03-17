


import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:location/location.dart' as location;
import 'package:location/location.dart';
import 'package:workonenight/entityclient/azienda.dart';
import 'package:workonenight/entityclient/posizionelatlong.dart';
import 'package:workonenight/services/utenteservice.dart';
import 'package:workonenight/services/utenteservice.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/barradiricerca.dart';
import 'package:workonenight/stilitema/buttons.dart';
import 'package:workonenight/stilitema/inputs.dart';


class AggiungiAzienda extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
     return AggiungiAziendaState();
  }

}




class AggiungiAziendaState extends State<AggiungiAzienda> {

  TextEditingController nomeaziendacontroller = new TextEditingController();
  TextEditingController indirizzoaziendacontroller = new TextEditingController();
  TextEditingController civicoaziendacontroller = new TextEditingController();


  String testopulsante = "Seleziona la posizione";

  double lat;
  double lng;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: appbarsenzaactions("Aggiungi azienda"),

       body: Container(
           child:
           GestureDetector(
               onTap: (){
                 FocusScope.of(context).requestFocus(new FocusNode());
               },
               child:
               SingleChildScrollView(
                 child:
                 Form(
                     key: _formKey,
                     child: Column(
                         children: <Widget>[
                           // Add TextFormFields and ElevatedButton here.
                           Padding(padding: EdgeInsets.only(bottom: 20),),
                           InputWidget(hinttext: "LA TUA ATTIVITA'", controller: nomeaziendacontroller, ispassword: false ,validator: defaultvalidatornonvuoto, labeltext: "Nome attività",),
                           Padding(padding: EdgeInsets.only(bottom: 20),),

                           entrabutton(testopulsante, context, () {prendiindirizzo(context);}),

                       /*    GestureDetector(
                               onTap: (){prendiindirizzo(context);},
                               child:
                               AbsorbPointer(
                                 child: InputWidget(hinttext: "Via Rossi", controller: indirizzoaziendacontroller, ispassword: false ,validator: defaultvalidator, labeltext: "Indirizzo",enabled: false,),
                               )
                           ), */
                           Padding(padding: EdgeInsets.only(bottom: 20),),
               //            InputWidget(hinttext: "56", controller: civicoaziendacontroller, ispassword: false ,validator: defaultvalidator, labeltext: "Numero civico",),
                           Padding(padding: EdgeInsets.only(bottom: 20),),
                           entrabutton("Aggiungi",context,(){formsubmit(context);}),
                         ]
                     )
                 ),

               )
           )
       ),
     );
  }

   prendiindirizzo(context) async {

     location.LocationData loc = await getcurrentlocation();

     if(loc == null) return;


     LocationResult result = await showLocationPicker(
       context, "AIzaSyBIZcfvodob7Z_U0sQKlsMNQAaUq5_SdyM",
       initialCenter: LatLng(loc.latitude, loc.longitude),
       countries: ['IT'],
       language: "it",
       hintText: "Cerca posizione",
       myLocationButtonEnabled: true,
     );

     final geocoding = GoogleMapsGeocoding(
         apiKey: 'AIzaSyBIZcfvodob7Z_U0sQKlsMNQAaUq5_SdyM');

     GeocodingResponse response = await geocoding.searchByPlaceId(result.placeId);

     print(response.results[0].formattedAddress);

     this.indirizzoaziendacontroller.text = response.results[0].formattedAddress;
     setState(() {
       this.testopulsante = response.results[0].formattedAddress;
     });


     this.lat = response.results[0].geometry.location.lat;
     this.lng = response.results[0].geometry.location.lng;


   //     var result = await showSearch(context: context, delegate: paginaricercamapbox);
   //     print(result);

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


  formsubmit(context){
    Azienda daaggiungere = new Azienda();
    daaggiungere.nomeazienda = this.nomeaziendacontroller.text;
    daaggiungere.nomelocation = this.testopulsante;
    daaggiungere.numerocivico = this.civicoaziendacontroller.text;
    PosizioneLatLong pos = new PosizioneLatLong();
    pos.latitudine = this.lat;
    pos.longitudine = this.lng;
    daaggiungere.posizionelatlong = pos;
    utenteService.aggiungiazienda(daaggiungere);
    // @todo
    print("ESCO");
    Navigator.of(context).pop();
  }

}