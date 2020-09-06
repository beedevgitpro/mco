import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mco/alert.dart';
import 'package:mco/app/components/animationAlert.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/pages/home/home_page.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:mco/app/utils/network_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'twofactorMethod.dart';

// 25158
class TwoFactor extends StatefulWidget {
  @override
  _TwoFactorState createState() => _TwoFactorState();
}

class _TwoFactorState extends State<TwoFactor> {
  final twofactorformKey = new GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int userid;
  SharedPreferences _sharedPreferences;
  String _otp;
  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
  }

  Future _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    // String authToken = AuthUtils.getToken(_sharedPreferences);
    userid = AuthUtils.getUserId(_sharedPreferences);
    // }
  }

  Widget _otpField() {
    return new TextFormField(
        autocorrect: false,
        validator: (input) =>
            input.length < 3 ? 'Should be more than 3 characters' : null,
        onSaved: (val) {
          _otp = val;
        },
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: 'Recieved OTP',
          // border: new OutlineInputBorder(
          //   // gapPadding: 10.0,
          //   borderRadius: new BorderRadius.circular(5.0),
          //   borderSide: new BorderSide(),
          // ),
          // icon: new Icon(Icons.person)
        ));
  }

  Widget _buildForm() {
    return new Form(
        autovalidate: true,
        key: twofactorformKey,
        child: new ListView(
            padding: const EdgeInsets.only(
              top: 150.0,
              left: 26.0,
              right: 26.0,
            ),
            children: <Widget>[
              SizedBox(
                height: 70.0,
                child:Icon(Icons.verified_user),
              ),
              ListTile(
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        "You'll get an OTP via SMS / Email",
                        textAlign: TextAlign.center,
                        // style: TextStyle()
                      )),
                  title: Text(
                    "Verification!",
                    style: TextStyle(
                        color: Color(0xFF192235),
                        fontWeight: FontWeight.w500,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 1 / 12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _otpField(),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 3 / 4,
                child: new RaisedButton(
                    shape: buttonCircularshape,
                    color: leadingColor,
                    child: Text(
                      'SEND  OTP',
                      style: buttonStyle,
                    ),
                    onPressed: () {
                      submit();
                    }),
              ),
              Container(
                child: new FlatButton(
                    shape: buttonCircularshape,
                    child: Text(
                      'Resend  Otp'.toUpperCase(),
                      style: TextStyle(color: leadingColor),
                    ),
                    onPressed: () {
                      print(userid);
                      resend(userid).then((onValue) {
                        if (onValue) {
                          alertShow(context, "OTP Sent Successfully", "",
                              AlertType.success, "Done", false);
                        } else {
                          alertShow(context, "Password Mismatch", "Try Again",
                              AlertType.error, "Failed", false);
                        }
                      });
                    }),
              )
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(body: _buildForm()),
    );
  }

  void submit() async {
    final form = twofactorformKey.currentState;
    if (form.validate()) {
      form.save();

      sendToken(userid, int.parse(_otp)).then((response) async {
        // print(response['userdata']['token_is_verify']);
        _sharedPreferences = await _prefs;
        response=jsonDecode(response);
        if (response['status'] == 200) {
          await AuthUtils.insertTokenChange(
              _sharedPreferences, response['userdata']['token_is_verify']);
          alertShow(context, "Verified Successfully", "", AlertType.success,
              "Done", true);
          Navigator.pushAndRemoveUntil(
            context,
            MyCustomRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
        } else {
          alertShow(context, response['error_msg'].toString().toUpperCase(),"", AlertType.error,
              "Failed", false);
        }
      });
    }
  }
}
// 30469