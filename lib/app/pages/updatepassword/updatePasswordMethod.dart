import 'package:dio/dio.dart';

import '../../constants.dart';

bool alertNavigate = false;
Dio dio = new Dio();
Future sendData(
  String oldPassword,
  String newPassword,
  String authToken,
) async {
  FormData formData = new FormData.fromMap({
    "old_password_confirmation": oldPassword,
    "password": newPassword,
  });
  Response response = await dio.post(updatePassword,
      data: formData,
      options: Options(headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $authToken',
      }));

  if (response.data['status'] != 200) {
    print(response.data["message"]);
    alertNavigate = false;
  } else {
    print(response.data["message"]);
    alertNavigate = true;
  }

  return alertNavigate;
}
