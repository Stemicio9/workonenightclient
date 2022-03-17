

import 'package:flutter/material.dart';
import 'package:workonenight/appstate/dashboardpagestate.dart';
import 'package:workonenight/bottombar/tabbar.dart';
import 'package:workonenight/bottombar/tabitemicon.dart';
import 'package:workonenight/datoredilavoro/profilo.dart';
import 'package:workonenight/datoredilavoro/pubblicaannuncio.dart';
import 'package:workonenight/drawermenu/menulaterale.dart';
import 'package:workonenight/stilitema/appbars.dart';
import 'package:workonenight/stilitema/costantitema.dart';

import 'annuncipubblicati.dart';
import 'notifiche.dart';
import 'ricercautenti.dart';

class DashboardDatore extends StatefulWidget {
  @override
  DashboardDatoreState createState() {
    return DashboardDatoreState();
  }

}

class DashboardDatoreState extends State<DashboardDatore>{




  ProfiloDatore profilo = new ProfiloDatore();
  PubblicaAnnuncio pubblica = new PubblicaAnnuncio();
  NotificheDatore notifiche = new NotificheDatore();
  RicercaUtenti ricerca = new RicercaUtenti();
  AnnunciPubblicati mieiannunci = new AnnunciPubblicati();

  void onChangeTab(int index) {
    print("CAMBIO TAB");
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 5,
      child: Scaffold(
        appBar: appbarconaction("Dashboard", context),

        drawer: MenuLaterale(),

        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            mieiannunci,
            ricerca,
            pubblica,
            notifiche,
            profilo
          ],
        ),
        bottomNavigationBar: JumpingTabBar(
          onChangeTab: onChangeTab,
          backgroundColor: Colors.blue,
          circleGradient: LinearGradient(
            colors: [
             giallo,
              Colors.amber,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          items: [
            TabItemIcon(
              iconData: Icons.wysiwyg,
              curveColor: Colors.white,
            ),

            TabItemIcon(
              iconData: Icons.search,
              curveColor: Colors.white,
            ),
            TabItemIcon(iconData: Icons.add, curveColor: Colors.white),
            TabItemIcon(
              buildWidget: (_, color) => Stack(
                children: <Widget>[
                  new Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.white,
                  ),
                  new Positioned(
                    top: 1.0,
                    right: 0.0,
                    child: new Stack(
                      children: <Widget>[
                        new Icon(
                          Icons.brightness_1,
                          size: 18.0,
                          color: verdepieno,
                        ),
                        new Positioned(
                          top: 1.0,
                          right: 4.0,
                          child: new Text("2",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
              curveColor: Colors.white
            ),
            TabItemIcon(iconData: Icons.person, curveColor: Colors.white),
          ],
          selectedIndex: selectedIndex,
        ),
      ),
    );
  }
}