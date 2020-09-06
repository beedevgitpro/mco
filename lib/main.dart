import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mco/app/pages/login/Loader.dart';
import 'app/AuthFlow.dart';

void main() {
     WidgetsFlutterBinding.ensureInitialized(); 
     SystemChrome.setPreferredOrientations(
     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
     runApp(AuthFlow());
     });
}
