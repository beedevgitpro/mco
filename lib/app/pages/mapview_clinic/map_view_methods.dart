import 'package:flutter/material.dart';
import 'package:mco/app/models/clinic_model.dart';
import 'package:mco/app/pages/bookform/book_form.dart';
import 'package:mco/app/pages/bookform/book_formClinic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//address to coordinates
addressToCoordinates(
    List<ClinicData> address, List<Placemark> coordinates) async {
  if (address.length != 0) {
    for (var item in address) {
      List<Placemark> placeMarkAdd =
          await Geolocator().placemarkFromAddress(item.addressLine1);
      coordinates.add(placeMarkAdd[0]);
      // print(
      //     "address = ${placemark.position}, ${placemark.subThoroughfare}, ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}");
    }
  }
}

Geolocator geolocator = Geolocator();
//get current location
Future<Position> getLocation() async {
  var currentLocation;
  try {
    currentLocation = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  } catch (e) {
    currentLocation = null;
  }
  return currentLocation;
}

//create markers
int markerid = 0;
Set<Marker> createMarker(
    List<ClinicData> placedData, BuildContext context) {
  return <Marker>[
    for(var i = 0; i < placedData.length; i++)
      Marker(
          markerId: MarkerId("${markerid++}"),
          position: LatLng(double.tryParse(placedData[i].clinicLat),
              double.tryParse(placedData[i].clinicLong)),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
              title: "${placedData[i].name}",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BookFormClinic(placedData[i])));
              })),
  ].toSet();
}
