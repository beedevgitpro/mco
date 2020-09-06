import 'package:dio/dio.dart';

import '../../constants.dart';

bool alertNavigate = false;
Dio dio = new Dio();
Future resend(
  int id,
) async {
  FormData formData = new FormData.fromMap({
    "user_id": id,
  });
  Response response = await dio.post(resendOtp,
      data: formData,
      options: Options(headers: {
        "Accept": "application/json",
      }));

  if (response.data['status'] != 200) {
    // print(response.data["message"]);
    alertNavigate = false;
  } else {
    print(response.data['error_msg']);

    alertNavigate = true;
  }

  return alertNavigate;
}

Future sendToken(
  int userid,int otp
) async {
  FormData formData = new FormData.fromMap({
    "user_id": userid,
    "otp":otp
  });
  Response response = await dio.post(verifyOtp,
      data: formData,
      options: Options(headers: {
        "Accept": "application/json",
      }));
  // if (response.data['status'] != 200) {
  //   print(response.data["message"]);
  //   alertNavigate = false;
  // } else {
  //   print(response.data["message"]);
  //   alertNavigate = true;
  // }

  return response.data;
}