


import 'package:flutter/material.dart';
import 'package:workonenight/bloc/ricercautentibloc.dart';

class RicercaUtenti extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return
   Container(
   child: UtentiProvider(utentebloc: UtentiBloc(), child: PaginaRicercaUtenti()),
   );
  }

}