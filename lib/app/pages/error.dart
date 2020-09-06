import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/pages/home/home_page.dart';

class UnderDevelopment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: Scaffold(
          body: Center(
              child: FadeAnimatedTextKit(
        duration: Duration(milliseconds: 5000),
        isRepeatingAnimation: false,
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MyCustomRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
        },
        text: [
          "The Page is",
          " Under Development!",
          "Thank You !!",
          "Tap on any Text to Go to the Dashboard"
        ],
        textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ))),
    );
  }
}
