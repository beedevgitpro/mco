import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  final String content =
      "Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.";

  @override
  Widget build(BuildContext context) {
    final topText = Container(
        margin: EdgeInsets.all(10.0),
        child: Text(
          content,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
        ));
    final mapImage = Container(
      height: MediaQuery.of(context).size.width * 1,
      width: MediaQuery.of(context).size.width * 0.80,
      child: GoogleMap(
                      myLocationEnabled: true,
                      scrollGesturesEnabled: true,
                      compassEnabled: true,
                      mapType: MapType.normal,
                      rotateGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(4.2105,101.9758),
                          zoom: 5.0),
                      onMapCreated: (GoogleMapController controller) {},
                    ),
    );
    final cardBottom1 = buildRow(
        "Address", "B 32, Patel shopping center, Borivali West", Icons.place);
    final cardBottom2 =
        buildRow("Contact Number", "0222-002-1211", Icons.phone);
    final cardBottom3 = buildRow("Email Id", "www.beedev.com.au", Icons.email);
    final bottomContent = Container(
      child: Column(
        children: <Widget>[
          InkWell(
              onTap: () {
                launch('https://www.google.com/search?q=BEEDEV SOLUTIONS');
              },
              child: cardBottom1),
          InkWell(
              onTap: () => launch("tel://0222-002-1211"), child: cardBottom2),
          InkWell(
              onTap: () => launch("mailto:www.beedev.com.au"),
              child: cardBottom3)
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: leadingColor,
        title: Text("About us"),
      ),
      body: ListView(
        children: <Widget>[topText, mapImage, bottomContent],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(activeTabNumber: 3,),
    );
  }

  Row buildRow(String key, String value, IconData icon) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(15.0),
          child: Icon(
            icon,
            color: Colors.indigo.shade100,
            size: 28.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              key,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              value,
              style: TextStyle(fontSize: 13.0),
            ),
          ],
        ),
      ],
    );
  }
}
