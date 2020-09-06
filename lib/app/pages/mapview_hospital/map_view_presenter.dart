import 'package:flutter/material.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/models/hospital_model.dart';
import 'package:mco/app/pages/clinic/clinic_list_search.dart';
import 'package:mco/app/pages/hospital/hospital_list_search.dart';
import 'package:mco/app/pages/login/Loader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_view_methods.dart';

Center buildMapView(BuildContext context, String title, Position userLocation,
 List<HospitalData> placedData, Icon icon) {
  return Center(
    child: userLocation == null
        ? ColorLoader4()
        : Stack(
            children: <Widget>[
              Scaffold(
                bottomNavigationBar: BottomNavBar(activeTabNumber: 1,),
                appBar: AppBar(
                  title: Text(" Book a $title "),
                  // leading: new IconButton(
                  //   icon: icon,
                  //   alignment: Alignment.center,
                  //   // onPressed: searchPressed,
                  // ),
                  actions: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.list),
                          onPressed: () {
                            Navigator.pop(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        title == "Clinic"
                                            ? ClinicPage()
                                            : HospitalPage()));
                          },
                        ))
                  ],
                ),
                body: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      scrollGesturesEnabled: true,
                      compassEnabled: true,
                      mapType: MapType.normal,
                      rotateGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      markers: createMarker(placedData, context),
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              userLocation.latitude, userLocation.longitude),
                          zoom: 02.0),
                      onMapCreated: (GoogleMapController controller) {},
                    ),
                  ),
                ),
              ),
              // textformdata(widget.title)
            ],
          ),
  );
}
