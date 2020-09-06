import 'package:flutter/material.dart';
import 'package:mco/app/models/clinic_model.dart';
import 'package:mco/app/models/hospital_model.dart';
import 'package:geolocator/geolocator.dart';

import 'map_view_methods.dart';
import 'map_view_presenter.dart';

class Map_View_Hospital extends StatefulWidget {
  String title;
  List<HospitalData> hospitalData = new List<HospitalData>();

  Map_View_Hospital(this.title, this.hospitalData);
  @override
  _Map_View_HospitalState createState() => _Map_View_HospitalState();
}

class _Map_View_HospitalState extends State<Map_View_Hospital> {
  Position userLocation;
  // List<hospitalData> passedData = [];
  // List<HospitalName> passedHospital = [];
  List<Placemark> coordinates = [];
  Icon _searchIcon = new Icon(Icons.search);

  @override
  void initState() {
    // gotHospitalClinicName(widget, widget.hospitalData,);
    // addressToCoordinates(widget.hospitalData, coordinates);
    getLocation().then((position) {
      setState(() {
          print("$position  get current location");

        userLocation = position;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildMapView(context, widget.title, userLocation,
        widget.hospitalData, _searchIcon);
  }
}
