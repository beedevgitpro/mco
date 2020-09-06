import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/models/hospital_model.dart';
import 'package:mco/app/pages/bookform/book_form.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalDetailPage extends StatefulWidget {
  final HospitalData hospitaldetails;
  HospitalDetailPage(this.hospitaldetails);

  @override
  _HospitalDetailPageState createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }
  
  bool isLarge(context){
    // print(MediaQuery.of(context).size.width);
    if(MediaQuery.of(context).size.width>350)
      return true;
    return false;
  }
  @override
  Widget build(BuildContext context) => new Scaffold(
      bottomNavigationBar: BottomNavBar(activeTabNumber: 1,),
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.hospitaldetails.name),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Book Appointment",
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.date_range),
        onPressed: () {
          Navigator.push(
              context,
              new MyCustomRoute(
                  builder: (BuildContext context) => new BookForm(
                      widget.hospitaldetails)));
        },
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
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
                      widget.hospitaldetails.name,
                      style: TextStyle(
                          fontSize: 30.0, color: Colors.white.withOpacity(0.9)),
                    ),
                    Wrap(
                      children: <Widget>[
                        widget.hospitaldetails.addressLine2 == null
                            ? Text(
                                '${widget.hospitaldetails.addressLine1}',
                                style: TextStyle(
                                    fontSize: isLarge(context)?15.0:12,
                                    color: Colors.white.withOpacity(0.8)),
                              )
                            : Text(
                                '${widget.hospitaldetails.addressLine1} ${widget.hospitaldetails.addressLine2} ${widget.hospitaldetails.addressLine3}',
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
              color: leadingColor,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.phone_android,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  InkWell(
                    onTap: () => launch("tel://${widget.hospitaldetails.contactTelNo}"),
                                      child: Text(widget.hospitaldetails.contactTelNo,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white.withOpacity(0.8))),
                  ),
                  Icon(Icons.email, color: Colors.white.withOpacity(0.8)),
                  InkWell(
                    onTap: ()=>launch("mailto:${widget.hospitaldetails.email}"),
                                      child: Text(widget.hospitaldetails.email,
                        style: TextStyle(
                            fontSize: 15.0, color: Colors.white.withOpacity(0.8))),
                  )
                ],
              ),
            ),
            Expanded(
              
              child: GoogleMap(
                zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      scrollGesturesEnabled: true,
                      compassEnabled: true,
                      mapType: MapType.normal,
                      rotateGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      markers:createMarker(widget.hospitaldetails,context),
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              double.tryParse(widget.hospitaldetails.hospitalLat), double.tryParse(widget.hospitaldetails.hospitalLong,)),
                          zoom: 10.0),
                      onMapCreated: (GoogleMapController controller) {},
                    ),
            )
          ],
        ),
      ));

 Set<Marker> createMarker(
    HospitalData placedData, BuildContext context) {
  return <Marker>[
      Marker(
          markerId: MarkerId("${1}"),
          position: LatLng(
                              double.tryParse(placedData.hospitalLat), double.tryParse(placedData.hospitalLong,)),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
              title: "${placedData.name}",
              onTap: (){})),
  ].toSet();
}


}
