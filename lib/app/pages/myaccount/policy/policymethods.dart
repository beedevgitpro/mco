import 'package:dio/dio.dart';
import 'package:mco/app/pages/myaccount/policy/policymodel.dart';

abstract class PolicyApiInterface {
  // Future<List<PolicyPlanDetails>> getUserPolicyFromProfileCode(
      // String authToken, bool submitting, String url, String recievedData);
}

class PolicyApiRepository implements PolicyApiInterface {
  final dio = new Dio();
  Response response;

  @override
  Future<List> getUserPolicyFromProfileCode(String authToken, bool submitting,
      String url, String parameters) async {
    response = await dio.get("$url/$parameters",
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $authToken',
        }));
    if (response.statusCode == 200) submitting = true;
    {
      Map<String, dynamic> responseJson = response.data;
            print("${response.data}  responsee");

      PolicyModel policyModel = PolicyModel.fromJson(responseJson);
     
      return policyModel.getPolicyDetails;
    }
  }
}
