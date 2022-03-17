


import 'package:location/location.dart' as loc;
import 'package:mapbox_search/mapbox_search.dart';
import 'package:workonenight/mappelocations/cercavia.dart';

import 'package:mapbox_search/mapbox_search.dart' as mapboxsearch;

import 'ricercatore.dart';

RicercatoreMapBox ricercatoremapbox = new RicercatoreMapBox();

class RicercatoreMapBox extends Ricercatore{


  @override
  Stream getstream(String query){
    var placesSearch = PlacesSearch(
      apiKey: mapboxapikey,
      limit: 5,
      country: paese,
      language: lingua
    );


    return placesSearch.getPlaces(query, location: prendilocationattuale()).asStream();
  }


  mapboxsearch.Location prendilocationattuale() {
    var locationtelefono = new loc.Location();

    locationtelefono.hasPermission().then((value) => (){
      if(value == loc.PermissionStatus.granted) {
        locationtelefono.getLocation().then((value) {
          return new mapboxsearch.Location(
              lat: value.latitude, lng: value.longitude);
        }, onError: (error) {
          return new mapboxsearch.Location();
        });
      }else{
        locationtelefono.requestPermission();
      }
    });


  }

}