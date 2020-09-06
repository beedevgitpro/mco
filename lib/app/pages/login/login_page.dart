import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mco/app/components/animationAlert.dart';
import 'package:mco/app/components/email_field.dart';
import 'package:mco/app/components/error_box.dart';
import 'package:mco/app/components/login_button.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/components/password_field.dart';
import 'package:mco/app/models/user.dart';
import 'package:mco/app/pages/home/home_page.dart';
import 'package:mco/app/pages/hospital/hospital_methods.dart';
import 'package:mco/app/pages/login/Loader.dart';
import 'package:mco/app/pages/twofactor/twofactor.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:mco/app/utils/network_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../alert.dart';
import '../../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKeylogin =
      new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  bool _isError = false;
  bool _obscureText = true;
  bool _isLoading = false;
  bool isScreenLarge;
  TextEditingController _emailController, _passwordController;
  String _errorText, _emailError, _passwordError;
  bool isLarge(context){
    print(MediaQuery.of(context).size.width);
    if(MediaQuery.of(context).size.width>350)
      return true;
    return false;
  }
  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    // });
  }

  Future _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    int isverfied = AuthUtils.getTokenIsVerify(_sharedPreferences);
    // print(isverfied);
    // if (isverfied == 0) {
    //   Navigator.pushReplacement(
    //     context,
    //     MyCustomRoute(builder: (context) => TwoFactor()),
    //   );
    // } else 
    if (isverfied == 1) {
      Navigator.pushAndRemoveUntil(
        context,
        MyCustomRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  _authenticateUser() async {
    _showLoading();
    try{
    if (_valid()) {
      var responseJson = await NetworkUtils.authenticateUser(
          _emailController.text, _passwordController.text);
      print(responseJson['errors']);
      if (responseJson == null) {
        NetworkUtils.showSnackBar(_scaffoldKeylogin, 'Please check your Internet');
        showToast('Please check your Internet');
      } else if (responseJson == 'NetworkError') {
        // NetworkUtils.showSnackBar(_scaffoldKeylogin, null);
        print('error');
      } 
      else if (responseJson['errors'] == '1') {
          NetworkUtils.showSnackBar(
              _scaffoldKeylogin, 'Invalid Email/Password');
          //_scaffoldKeylogin.currentState.showSnackBar(SnackBar(content: Text('Something Went wrong')));
        }
      else if (responseJson['userdata'] != null) {
        print(responseJson['userdata']);
        if (responseJson['userdata']['is_login'] == 1) {
          NetworkUtils.showSnackBar(_scaffoldKeylogin, 'Already LoggedIn');
          Alert(
            context: _scaffoldKeylogin.currentContext,
            type: AlertType.warning,
            title: "Already LoggedIn on other devices! Logout from other devices?",

            // desc: description,
            buttons: [
              DialogButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  navigatoBack(context);
                },
                color: Colors.red,
              ),
              DialogButton(
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  getLogOutCall(responseJson['userdata']['id']).then((value) {
                    print(value);
                    navigatoBack(context);
                    NetworkUtils.showSnackBar(_scaffoldKeylogin,
                        'Logout Successful from another Device');
                  });
                },
                color: Color(0xFF2d50ce),
                // gradient: LinearGradient(colors: [
                //   Color.fromRGBO(116, 116, 191, 1.0),
                //   Color.fromRGBO(52, 138, 199, 1.0)
                // ]),
              )
            ],
          ).show();
        } else if (responseJson['userdata']['token_is_verify'] == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MyCustomRoute(builder: (context) => TwoFactor()),
            (Route<dynamic> route) => false,
          );
          AuthUtils.insertDetails(_sharedPreferences, responseJson); //uncomment
        }

        // Navigator.of(_scaffoldKeylogin.currentContext)
        //     .pushReplacementNamed(HomePage.routeName);
      }
      print(responseJson);

      _hideLoading();
    } else {
      print('else');
      setState(() {
        _isLoading = false;
      });
    }} catch(e){
        _hideLoading();
        NetworkUtils.showSnackBar(_scaffoldKeylogin, 'Something went wrong!');
        showToast('Error: '+e.toString());
    }
  }

  _valid() {
    bool valid = true;
    if (_emailController.text.isEmpty) {
      valid = false;
      _emailError = "Please enter a valid Email";
    }

    if (_passwordController.text.isEmpty) {
      valid = false;
      _passwordError = "Please enter valid password";
    } 

// else if (_passwordController.text.length < 6) {
//       valid = false;
//       _passwordError = "Password is invalid!";
//     }
    print(valid);
    return valid;
  }

  Widget _loginScreen() {
    return Center(
      child: new Container(
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.only(
            top: 100.0,
            left: 26.0,
            right: 26.0,
          ),
          children: <Widget>[
            SizedBox(height: 30.0),

            new ErrorBox(isError: _isError, errorText: _errorText),
            SizedBox(height: 30.0),
            Text(
              "Welcome",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: isLarge(context)?35.0:30),
              textAlign: TextAlign.center,
            ),
            SizedBox(height:MediaQuery.of(context).size.height*1/12),
            new EmailField(
                emailController: _emailController, emailError: _emailError),
                SizedBox(height: isLarge(context)?25.0:10),
            new PasswordField(
              passwordController: _passwordController,
              obscureText: _obscureText,
              passwordError: _passwordError,
              togglePassword: _togglePassword,
            ),
            SizedBox(height: isLarge(context)?25.0:8),
            new LoginButton(onPressed: _authenticateUser),
            // new ForgetPassword()
          ],
        ),
      ),
    );
  }

  _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _loadingScreen() {
    return ColorLoader4();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKeylogin,
        body: _isLoading ? _loadingScreen() : _loginScreen());
  }
}

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        "Forget Password ?",
        style:
            TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.4)),
      ),
      onPressed: () => print("object"),
    );
  }
}

Future getLogOutCall(userid) async {
  Response response;
  try {
    response = await Dio().get("$logoutApi/$userid",
        options: Options(headers: {
          "Accept": "application/json",
        }));
  } catch (e) {
    print(e);
  }
  return response;
}
