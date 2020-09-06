import 'package:flutter/material.dart';
import 'package:mco/app/pages/home/home_page.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'pagenavigator.dart';

class SuccessFul extends StatefulWidget {
  @override
  _SuccessFulState createState() => _SuccessFulState();
}

class _SuccessFulState extends State<SuccessFul> {
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rating"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Center(
              child: AlertDialog(
                title: Text("Rate the booking "),
                content: Column(
                  children: <Widget>[
                    SmoothStarRating(
                      allowHalfRating: true,
                      onRated: (v) {
                        setState(() {
                          rating = v;
                        });
                      },
                      starCount: 5,
                      rating: rating,
                      size: 40.0,
                      color: Colors.green,
                      borderColor: Colors.green,
                    ),
                    Text("${rating.roundToDouble()}")
                  ],
                ),
                actions: <Widget>[submit(context), cancel],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget submit(BuildContext context) {
  return FlatButton(
    child: Text("Submit"),
    onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MyCustomRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    },
  );
}

final cancel = FlatButton(
  child: Text("Cancel"),
  onPressed: () => print("Cancel"),
);
