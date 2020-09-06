import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  Color activeColor;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: leadingColor,
        title: Text(" FAQ's "),
      ),
      bottomNavigationBar: BottomNavBar(activeTabNumber: 4,),
      body: new ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, i) {
          return new ExpansionTile(
            onExpansionChanged: (value){
              setState(() {
                value?activeColor=Color(0xFF2d50ce):activeColor=Colors.black;
              });
            },
            title: new Text(
              vehicles[i].title,
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  ),
            ),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(vehicles[i]),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        new ListTile(
          title: new Text(
            content,
            style: new TextStyle(fontSize: 18.0),
          ),
          leading: new Icon(vehicle.icon),
        ),
      );

    return columnContent;
  }
}

class Vehicle {
  final String title;
  List<String> contents = [];
  final IconData icon;

  Vehicle(this.title, this.contents, this.icon);
}

List<Vehicle> vehicles = [
  new Vehicle(
    'Diseases',
    ['Cancer', 'Eleplantasis', 'Tuberculosis', 'Typhoid'],
    Icons.local_hospital,
  ),
  new Vehicle(
    'Cure',
    ['Suthol', 'Detol', 'Clean the Wound with antiseptic'],
    Icons.healing,
  ),
  new Vehicle(
    'Prevention',
    ['Wash your hands', 'Wear clean clothers', 'Bath Daily'],
    Icons.branding_watermark,
  ),
];
