

import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';

import 'ricercatori/ricercatore.dart';
import 'ricercatori/ricercatoremapboxlocations.dart';

PaginaRicerca paginaricercamapbox = new PaginaRicerca(ricercatore: ricercatoremapbox);

class PaginaRicerca extends SearchDelegate{

  Ricercatore ricercatore;

  MapBoxPlace selectedresult;

  PaginaRicerca({this.ricercatore});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

     return Container(
       child: Center(
         child: Text(this.selectedresult.text)
       )
     );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Container();
    }


    return Column(
      children: <Widget>[
        //Build the results based on the searchResults stream in the searchBloc
        StreamBuilder(
          stream: ricercatore.getstream(query),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data.length == 0) {
              return Column(
                children: <Widget>[
                  Text(
                    "Nessun risultato",
                  ),
                ],
              );
            } else {
              var results = snapshot.data;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: results.length,
                itemBuilder: (context, index) {
                  var result = results[index];
                  return
                    GestureDetector(
                      onTap: (){
                        this.selectedresult = result;
                        query = result.placeName;
                        },
                      child: ListTile(
                    title: Text(result.placeName),
                      )
                    );

                },
              );
            }
          },
        ),
      ],
    );
  }

}