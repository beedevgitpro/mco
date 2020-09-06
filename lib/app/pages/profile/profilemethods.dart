import 'package:dio/dio.dart';
import 'package:mco/app/constants.dart';
import 'package:mco/app/pages/myaccount/ecard/ecardmodel.dart';
import 'package:mco/app/pages/profile/empnationalitymodel.dart';
import 'package:mco/app/pages/profile/profilemodel.dart';

class ProfileRepository {
  final dio = new Dio();
  Response response;

  @override
  Future<List> getUserDataFromProfileCode(String authToken, bool submitting,
      String url, String parameters) async {
    response = await dio.get("$url/$parameters",
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $authToken',
        }));
    if (response.statusCode == 200) submitting = true;
    {
      Map<String, dynamic> responseJson = response.data;

      ProfileModel profileModel = ProfileModel.fromJson(responseJson);

      print(profileModel.userData[0].name);
      return profileModel.userData;
    }
  }

//  Future profileExtraFields() async {

//     try {
//       List<Response> responselist = await Future.wait([dio.get(getNationalityApi, options: Options(headers: {
//           "Accept": "application/json",
//           'Authorization': 'Bearer $auth',
//         })), dio.get(getState, options: Options(headers: {
//           "Accept": "application/json",
//           'Authorization': 'Bearer $auth',
//         }))]);

//   //  for (int i = 0; i < responselist.length; i++) {
//   //    print(responselist[i].data);
//   //   }
//     // EmpNationality empNationality=EmpNationality.fromJson(responselist[0].data);
//     // print(empNationality.statecode[0].description);
//     return responselist;
//     } catch (e) {
//       print(e);
//     }
//   }

    Future<List> getNationality(String authToken, bool submitting, String url, String recievedData) async {
    response = await dio.get(getNationalityApi,
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $authToken',
        }));
    if (response.statusCode == 200) submitting = true;
    {
      Map<String, dynamic> responseJson = response.data;

      EmpNationalityModel nationalityModel = EmpNationalityModel.fromJson(responseJson);

      return nationalityModel.getNationality;
    }
  }
}
