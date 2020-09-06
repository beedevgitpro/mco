import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/pages/home/home_page.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../alert.dart';
import 'updatePasswordMethod.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final formKey = new GlobalKey<FormState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;
  String authToken;
  int getIsPasswordChange;
  Future fetchToken() async {
    _sharedPreferences = await _prefs;
    authToken = AuthUtils.getToken(_sharedPreferences);
    getIsPasswordChange = AuthUtils.getIsPasswordChange(_sharedPreferences);
    print(authToken);

  }


  String _password;
  String _passwordConfirm;

  Widget _passwordField() {
    return new TextFormField(
        autocorrect: false,
        obscureText: true,
        validator: (input) =>
            input.length < 3 ? 'Should be more than 3 characters' : null,
        onSaved: (val) => _password = val,
        decoration: InputDecoration(
          labelText: 'Current Password',
          border: new OutlineInputBorder(
            // gapPadding: 10.0,
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(),
          ),
          // icon: new Icon(Icons.person)
        ));
  }

  Widget _passwordConfirmField() {
    return new TextFormField(
        autocorrect: false,
        obscureText: true,
        validator: (input) =>
            input.length < 3 ? 'Should be more than 3 characters' : null,
        onSaved: (val) => _passwordConfirm = val,
        decoration: InputDecoration(
          labelText: 'New Password',
          border: new OutlineInputBorder(
            // gapPadding: 10.0,
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(),
          ),
          // icon: new Icon(Icons.person)
        ));
  }

  Widget _buildForm() {
    return new Form(
        autovalidate: true,
        key: formKey,
        child: new Column(children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _passwordField(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _passwordConfirmField(),
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 3 / 4,
            child: new RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: leadingColor,
                child: Text(
                  'Update Password',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => submit()),
          )
        ]));
  }

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();

      var value = await sendData(_password, _passwordConfirm, authToken);
      print('$value  value');
      if (value) {
        AuthUtils.insertPasswordChange(_sharedPreferences, 1);
        alertShow(context, "Password Changed Successfully", "",
            AlertType.success, "Done", true);
        Navigator.pushAndRemoveUntil(
          context,
          MyCustomRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
      } else {
        alertShow(context, "Password Mismatch", "Try Again", AlertType.error,
            "Failed", false);
      }
    } else {
      alertShow(
          context, "Fields required", "", AlertType.error, "Failed", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leadingColor,
        title: Text("Update Password"),
      ),
      body: _buildForm(),
      // bottomNavigationBar: MyBottomBar(),
    );
  }
}
