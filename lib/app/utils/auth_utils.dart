import 'package:mco/app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  // static final String endPoint = '/login_api';
  // Keys to store and fetch data from SharedPreferences
  static final String authTokenKey = 'token';
  static final String userIdKey = 'user_id';
  static final String nameKey = 'name';
  static final String profileCode='user_profile_code';
  static final String tokenIsVerify='token_is_verify';
    static final String ispasswordchange='is_password_change';

  // static final String roleKey = 'role';
  
  static String getToken(SharedPreferences prefs) {
    return prefs.getString(authTokenKey);
  }

  static int getUserId(SharedPreferences prefs) {
    return prefs.getInt(userIdKey);
  }

 static String getUserProfileCode(SharedPreferences prefs) {
    return prefs.getString(profileCode);
  }

 static int getTokenIsVerify(SharedPreferences prefs) {
    return prefs.getInt(tokenIsVerify);
  }
   static int getIsPasswordChange(SharedPreferences prefs) {
    return prefs.getInt(ispasswordchange);
  }
  static insertDetails(SharedPreferences prefs, var response) {
    // print(response['userdata'][0]);
    prefs.setString(authTokenKey, response['token']);
    prefs.setInt(userIdKey,response['userdata']['id']);
    prefs.setString(profileCode,response['userdata']['user_profile_code']); 
    // if(response['userdata'][0]['token_2fa'].runtimeType  ==int){
    // }
    // else{
       prefs.setInt(tokenIsVerify,response['userdata']['token_is_verify']); 
    // }
    prefs.setInt(ispasswordchange,response['userdata']['is_password_change']); 
  }
  static insertTokenChange(SharedPreferences prefs, int response){
        prefs.setInt(tokenIsVerify,response); 
  }
  static insertPasswordChange(SharedPreferences prefs, int response){
        prefs.setInt(ispasswordchange,response); 
  }

}
