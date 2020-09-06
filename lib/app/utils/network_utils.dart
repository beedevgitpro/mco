import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mco/app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'auth_utils.dart';

class NetworkUtils {
  // static final String host = productionHost;
  // static final String productionHost = 'http://mconew.beedevstaging.com/api';
  // static final String developmentHost = 'http://mconew.beedevstaging.com/api';

  static dynamic authenticateUser(String email, String password) async {
    var uri = "${baseurl}login_api";
    try {
      final response =
          await http.post(uri, body: {'email': email, 'password': password});
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      //   final response =
      //       await http.post(uri, body: {'email': email, 'password': password});
      //   // final responseJson = ;
      final responsedData = json.decode(response.body);
      // print(responsedData['userdata'].toString()+"ssssssssssssssssss");

      return responsedData;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  static logoutUser(BuildContext context, SharedPreferences prefs) {
    // prefs.setString(AuthUtils.authTokenKey, null);
    // prefs.setString(AuthUtils.authTokenKey, null);
    // prefs.setString(AuthUtils.authTokenKey, null);
    // prefs.setInt(AuthUtils.userIdKey, null);
    // prefs.setString(AuthUtils.token2fa, null);
    prefs.clear();
    Navigator.of(context).pushReplacementNamed('/');
  }

  static showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message ?? 'You are offline'),
    ));
  }

  static fetch(var authToken, var endPoint) async {
    var uri = baseurl + endPoint;

    try {
      final response = await http.get(
        uri,
        headers: {'Authorization': authToken},
      );

      final responseJson = json.decode(response.body);
      return responseJson;
    } catch (exception) {
      print(exception);
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }
}
