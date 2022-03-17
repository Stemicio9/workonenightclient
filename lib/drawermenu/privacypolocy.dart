


import 'package:flutter/material.dart';
import 'package:workonenight/stilitema/appbars.dart';

class PrivacyPolicy extends StatefulWidget{
  @override
  PrivacyPolicyState createState() {
    return PrivacyPolicyState();
  }

}


class PrivacyPolicyState extends State<PrivacyPolicy> {

  String policy1 = "aaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa"
      "aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaa"
      "aaaaaa aaaaaaaaaaaaaaaaa a  aaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaa aa"
      "aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaa";

  String policy2 = "aaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa"
      "aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaa"
      "aaaaaa aaaaaaaaaaaaaaaaa a  aaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaa aa"
      "aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaa";

  String policy3 = "aaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaa"
      "aaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaaa aaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaaa"
      "aaaaaa aaaaaaaaaaaaaaaaa a  aaaaaaaaaaaaaaaaa aaaaaaaaaaa aaaaaaaaaaaaaa aaaaaaaaaaaa aaaaaaaaaa aaaaaaaaaaaaa aa"
      "aaaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaaa aaaaaaaaaaaaaa";


  List<Item> data = List();


  PrivacyPolicyState(){
    Item primo = Item(headervalue: "Policy 1" , expandedvalue: policy1);
    Item secondo = Item(headervalue: "Policy 2" , expandedvalue: policy2);
    Item terzo = Item(headervalue: "Policy 3" , expandedvalue: policy3);

    data.add(primo);
    data.add(secondo);
    data.add(terzo);
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
         appBar: appbarsenzaactions("Policy Privacy"),

         body: SingleChildScrollView(
           child: Container(
             child: buildpanel(),
           ),
         ),
       );
  }


  Widget buildpanel(){
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState((){
          data[index].isexpanded = !isExpanded;
        });
      },

      children: data.map<ExpansionPanel>((Item item){
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headervalue),
            );
          },
          body: ListTile(
            title: Text(item.expandedvalue),
            onTap: () {
              setState(() {
                data.removeWhere((currentItem) => item == currentItem);
              });
            },
          ),
          isExpanded: item.isexpanded
        );
      }).toList(),
    );
  }





}


class Item {
  String expandedvalue;
  String headervalue;
  bool isexpanded;

  Item({this.expandedvalue, this.headervalue, this.isexpanded = false});
}

List<Item> generaitems(int numeroitems){
  return List.generate(numeroitems, (index) {
    return Item(
      headervalue: 'Sezione $index',
      expandedvalue: 'Sezione $index'
    );
  });
}