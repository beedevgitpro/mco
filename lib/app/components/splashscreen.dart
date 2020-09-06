// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geo/app/components/pagenavigator.dart';
// import 'package:geo/app/pages/login/login_page.dart';
// import 'package:connectivity/connectivity.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => new _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   var _connectionStatus = 'Unknown';
//   Connectivity connectivity;
//   StreamSubscription<ConnectivityResult> subscription;
//   @override
//   void initState() {
//     super.initState();
//     connectivity = new Connectivity();
//     subscription =
//         connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       _connectionStatus = result.toString();
//       print(_connectionStatus);
//       // if (result == ConnectivityResult.wifi ||
//       //     result == ConnectivityResult.mobile) {
//       setState(() {
//         new Future.delayed(
//             const Duration(seconds: 3),
//             () => Navigator.pushReplacement(
//                   context,
//                   MyCustomRoute(builder: (context) => LoginPage()),
//                 ));
//       });
//       // }
//     });
//   }

//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         child: new Column(children: <Widget>[
//           Divider(
//             height: 240.0,
//             color: Colors.white,
//           ),
//           new Image.asset(
//             'lib/app/assets/logo.png',
//             fit: BoxFit.cover,
//             repeat: ImageRepeat.noRepeat,
//             width: 170.0,
//           ),
//           Divider(
//             height: 105.2,
//             color: Colors.white,
//           ),
//         ]),
//       ),
//     );
//   }
// }
