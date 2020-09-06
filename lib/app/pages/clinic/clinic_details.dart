import 'package:flutter/material.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/models/clinic_model.dart';
import 'package:mco/app/pages/bookform/book_formClinic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinicDetailsPage extends StatelessWidget {
  ClinicDetailsPage(this.clinicDetails);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  final ClinicData clinicDetails;
  bool isLarge(context){
    if(MediaQuery.of(context).size.width>350)
      return true;
    return false;
  }
  @override
  Widget build(BuildContext context) => new Scaffold(
      bottomNavigationBar: BottomNavBar(activeTabNumber: 1,),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(clinicDetails.name),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Book Appointment",
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.date_range),
        onPressed: () {
          Navigator.push(
              context,
              new MyCustomRoute(
                  builder: (BuildContext context) => new BookFormClinic(
                      clinicDetails)));
        },
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade100,
                  Colors.indigo[500],
                ],
                stops: [0.0, 1.0],
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft,
              )),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      clinicDetails.name,
                      style: TextStyle(
                          fontSize: 30.0, color: Colors.white.withOpacity(0.9)),
                    ),
                    Wrap(
                      children: <Widget>[
                        clinicDetails.addressLine2 == null
                            ? Text(
                                '${clinicDetails.addressLine1} ',
                                style: TextStyle(
                                    fontSize: isLarge(context)?15.0:12,
                                    color: Colors.white.withOpacity(0.8)),
                              )
                            : Text(
                                '${clinicDetails.addressLine1} ${clinicDetails.addressLine2} ${clinicDetails.addressLine3}',
                                style: TextStyle(
                                    fontSize: isLarge(context)?15.0:12,
                                    color: Colors.white.withOpacity(0.8)),
                              ),
                        SmoothStarRating(
                          color: Colors.white70,
                          rating: 3.1,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.indigo.withAlpha(200),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(
                        Icons.phone_android,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      InkWell(
                    onTap: () => launch("tel://${clinicDetails.contactTelNo}"),

                                      child: Text(clinicDetails.telNo,
                        style: TextStyle(
                            fontSize: isLarge(context)?15.0:14,
                            color: Colors.white.withOpacity(0.8))),
                  ),
                    ],
                  ),
                  SizedBox(width:isLarge(context)?0:20),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.white.withOpacity(0.8)),
                      InkWell(
                    onTap: ()=>launch("mailto:${clinicDetails.email}"),
                    child: Text(clinicDetails.email,
                        style: TextStyle(
                            fontSize: isLarge(context)?15.0:14, color: Colors.white.withOpacity(0.8))),
                  )
                    ],
                  ),
                  
                ],
              ),
            ),
            Expanded(
              // height: MediaQuery.of(context).size.height * 1.58 / 4,
              // width: MediaQuery.of(context).size.width * 1,
              // color: Colors.black,
              // child: Image.asset("lib/app/assets/map2.png", fit: BoxFit.fill),
                         child: GoogleMap(
                           zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      scrollGesturesEnabled: true,
                      compassEnabled: true,
                      mapType: MapType.normal,
                      rotateGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      markers:createMarker(clinicDetails,context),
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              double.tryParse(clinicDetails.clinicLat), double.tryParse(clinicDetails.clinicLong)),
                          zoom: 10.0),
                      onMapCreated: (GoogleMapController controller) {},
                    ),
            )
          ],
        ),
      ));


       Set<Marker> createMarker(
    ClinicData placedData, BuildContext context) {
  return <Marker>[
      Marker(
          markerId: MarkerId("${1}"),
          position: LatLng(
                              double.tryParse(placedData.clinicLat), double.tryParse(placedData.clinicLong,)),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
              title: "${placedData.name}",
              onTap: (){})),
  ].toSet();
}

}
