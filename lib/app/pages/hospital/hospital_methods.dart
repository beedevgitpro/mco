import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mco/app/models/bulletin_model.dart';
import 'package:mco/app/models/clinic_model.dart';
import 'package:mco/app/models/hospital_model.dart';
import 'package:mco/app/pages/myaccount/claims/claimsmodel.dart';
import 'package:mco/app/utils/network_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

logout(BuildContext currentContext, SharedPreferences sharedPreferences) {
  NetworkUtils.logoutUser(currentContext, sharedPreferences);
}

final dio = new Dio();
Response response;

Future<List> getNames(
    String authToken, bool submitting, String url, String recievedData) async {
  response = await dio.get(url,
      options: Options(headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $authToken',
      }));
  if (response.statusCode == 200) submitting = true;
  {
    List tempList = new List();
    for (int i = 0; i < response.data[recievedData].length; i++) {
      tempList.add(response.data[recievedData][i]);
    }
    return tempList;
  }
}

// http://mconew.beedevstaging.com/api/hospital_api

Future<List> getNamesHospital(
    String authToken, bool submitting, String url) async {
  response = await dio.get(url,
      options: Options(headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $authToken',
      }));

  if (response.statusCode == 200) submitting = true;
  {
    Map<String, dynamic> responseJson = response.data;
    HospitalModel hospitalModel = HospitalModel.fromJson(responseJson);
    return hospitalModel.hospitalData;
  }
}

Future<List> getNamesClinic(
    String authToken, bool submitting, String url) async {
  response = await dio.get(url,
      options: Options(headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $authToken',
      }));

  if (response.statusCode == 200) submitting = true;
  {
    Map<String, dynamic> responseJson = response.data;
    ClinicModel clinicModel = ClinicModel.fromJson(responseJson);
    return clinicModel.clinicData;
  }
}

Future<List> getNamesBulletins(
    String authToken, bool submitting, String url) async {
  response = await dio.get(url,
      options: Options(headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $authToken',
      }));

  if (response.statusCode == 200) submitting = true;
  {
    Map<String, dynamic> responseJson = response.data;
    BulletinModel bulletinModel = BulletinModel.fromJson(responseJson);
    return bulletinModel.bulletinData;
  }
}
Future<List> getClaims(
    String authToken, bool submitting, String url, String parameters) async {
    response = await dio.get("$url/$parameters",
      options: Options(headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $authToken',
      }));

  if (response.statusCode == 200) submitting = true;
  {
    Map<String, dynamic> responseJson = response.data;
      ClaimsModel claimsModel;
   claimsModel = ClaimsModel.fromJson(responseJson);
    return claimsModel.getClaims;
  }
  
}
