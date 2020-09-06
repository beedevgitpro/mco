import 'package:flutter/material.dart';
import 'package:mco/app/models/clinic_model.dart';
import 'package:geolocator/geolocator.dart';

import 'map_view_methods.dart';
import 'map_view_presenter.dart';

class Map_View_Clinic extends StatefulWidget {
  String title;
  List<ClinicData> clinicData = new List<ClinicData>();

  Map_View_Clinic(this.title, this.clinicData);
  @override
  _Map_View_ClinicState createState() => _Map_View_ClinicState();
}

class _Map_View_ClinicState extends State<Map_View_Clinic> {
  Position userLocation;
  // List<ClinicData> passedData = [];
  // List<HospitalName> passedHospital = [];
  List<Placemark> coordinates = [];
  Icon _searchIcon = new Icon(Icons.search);

  @override
  void initState() {
    // gotHospitalClinicName(widget, widget.clinicData,);
    // addressToCoordinates(widget.clinicData, coordinates);
    getLocation().then((position) {
      setState(() {
        userLocation = position;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildMapView(context, widget.title, userLocation,
        widget.clinicData, _searchIcon);
  }
}
