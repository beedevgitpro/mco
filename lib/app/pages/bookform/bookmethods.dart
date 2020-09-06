
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


import '../../constants.dart';

Dio dio = new Dio();

Future sendDataClinic(
    String filepath,
    String filename,
    String fullName,
    String nric,
    int phoneNo,
    String date,
    String time,
    int policyNo,
    String issue,
    String authToken,
    int userId,
    int clinicId) async {

  FormData formData = new FormData.fromMap({
    "name": fullName,
    "nric": nric,
    "phone_no": phoneNo,
    "date": date,
    "time":time,
    "policy_no": policyNo,
    "message": issue,
    "user_id": userId,
    "clinic_id": clinicId,
    "file_upload[]":
        filepath.isEmpty? [] : MultipartFile.fromFile(filepath,
            filename: filename)
  });
  final response = await dio.post(clinicBookingApi,
      data: formData,
      options: Options(headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $authToken',
      }));

  print(response.data["success"]);
}

Future sendDataHospital(
    String filepath,
    String filename,
    String fullName,
    String nric,
    String phoneNo,
    String date,
    String time,
    String policyNo,
    String issue,
    String authToken,
    int userId,
    int hospitalId) async {
  FormData formData = new FormData.fromMap({
    "name": fullName,
    "nric": nric,
    "phone_no": phoneNo,
    "date": date,
    "time": time,
    "policy_no": policyNo,
    "message": issue,
    "user_id": userId,
    "hospital_id": hospitalId,
    "file_upload[]":
        filepath.isEmpty? [] : MultipartFile.fromFile(filepath,
            filename: filename)
  });
// for (int i = 0; i < files.length; i++) {
//     formData.add('file_' + i.toString(),
//         new UploadFileInfo(new File(files[i]), files[i].toString()));
// }
  final response = await dio.post(hospitalBookingApi,
      data: formData,
      options: Options(headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $authToken',
      }));

  print(response.data["success"]);
}
