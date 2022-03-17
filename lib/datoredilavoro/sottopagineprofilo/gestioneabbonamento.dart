

import 'package:flutter/material.dart';
import 'package:workonenight/stilitema/appbars.dart';

class GestioneAbbonamento extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: appbarsenzaactions("Pacchetti"),

        body: Container(
          padding: EdgeInsets.only(left: 8, right: 8),

          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(bottom: 10)),

            ],
          ),
        ),
      );
  }

}

