import 'package:flutter/material.dart';
import 'package:mco/app/pages/bulletin/Bulletin_page.dart';
import 'package:mco/app/pages/clinic/clinic_list_search.dart';
import 'package:mco/app/pages/home/home_page.dart';
import 'package:mco/app/pages/login/login_page.dart';
import 'package:mco/app/pages/myaccount/myaccount.dart';
import 'package:oktoast/oktoast.dart';
import 'package:splashscreen/splashscreen.dart';
import 'pages/hospital/hospital_list_search.dart';
import 'pages/myaccount/policy/policyList.dart';

// var faq = [
//   {"question": "as", "answer": "answe1"},
//   {"question": "as", "answer": "answe1"},
//   {"question": "as", "answer": "answe1"}
// ];

class AuthFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(child: buildMaterialApp());
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MCO App',
        theme: new ThemeData(
            primaryColor: Colors.indigo.shade500,
            textSelectionColor: Colors.green.shade500,
            buttonColor: Colors.green.shade500,
            accentColor: Color(0xFF2d50ce),
            bottomAppBarColor: Colors.white),
        routes: {HomePage.routeName: (BuildContext context) => new HomePage()},
        home: new SplashScreen(
          loadingText: Text("Loading..."),
          seconds: 05,
          navigateAfterSeconds: new LoginPage(),
          // title: new Text(
          //   "MCO APP",
          //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0
          //       // color:
          //       ),
          // ),
          image: Image.asset(
            'lib/app/assets/logo.png',
            // fit: BoxFit.cover,
            // repeat: ImageRepeat.noRepeat,
            // height: ,
            // width: ,
          ),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 150.0,
          onClick: () => print("Flutter Egypt"),
          loaderColor: Colors.red,
        ));
  }
}
