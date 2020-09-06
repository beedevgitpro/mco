import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/constants.dart';
import 'package:mco/app/pages/home/home_page.dart';
import 'package:mco/app/pages/login/Loader.dart';
import 'package:mco/app/pages/profile/profilemethods.dart';
import 'package:mco/app/pages/profile/profilemodel.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'empnationalitymodel.dart';

// import 'package:login_statefull/src/screens/dashtest.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profileApi = ProfileRepository();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String authToken;
  SharedPreferences _sharedPreferences;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = true;
  bool _isenabled = false;
  String sendButtonName = "Edit";
  List<UserData> profiledata = [];
  List<UserData> profiledatalogan = [];
  List<GetNationality> nationalityData = [];
  List<GetNationality> nationalityDataMore = [];

//dropdown
  String _dropNationality;
  @override
  void initState() {
    super.initState();
    validateLogin();
    // _dropNationality='';
  }

  validateLogin() async {
    _sharedPreferences = await _prefs;
    authToken = AuthUtils.getToken(_sharedPreferences);
    profiledata = await profileApi.getUserDataFromProfileCode(
        authToken, _isenabled, getUserProfile, "sumit");
    nationalityData = await profileApi.getNationality(
        authToken, _isenabled, getUserProfile, "sumit");

    print(profiledata[0].name);
    setState(() {
      profiledatalogan = profiledata;
      nationalityDataMore = nationalityData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavBar(activeTabNumber: 1,),
        appBar: AppBar(
          backgroundColor: leadingColor,
          title: Text("My Profile"),
        ),
        body: SingleChildScrollView(
          child: profiledata.length == 0
              ? ColorLoader4()
              : Container(
                  margin: new EdgeInsets.all(15.0),
                  child: Form(
                    child: formUI(),
                    key: _key,
                    autovalidate: _validate,
                  ),
                ),
        ),
      ),
    );
  }

  Widget formUI() {
    _sendToServer() {
      if (_isenabled) {
        if (_key.currentState.validate()) {
          _key.currentState.save();
          print("Name ${profiledatalogan[0].name}");
          print("Name ${profiledatalogan[0].addressLine1}");
          // print("phone $mobile");
          Navigator.pushAndRemoveUntil(
            context,
            MyCustomRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
        } else {
          setState(() {
            _validate = true;
          });
        }
        setState(() {
          _isenabled = false;
          sendButtonName = "Edit";
        });
      } else {
        setState(() {
          _isenabled = true;
          sendButtonName = "Save";
        });
      }
    }

    validateName(String value) {
      if (value.length == 0) {
        return "Name is Required";
      } else {
        return null;
      }
    }

    String validateEmail(String value) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if (value.length == 0) {
        return "Email is Required";
      } else if (!regExp.hasMatch(value)) {
        return "Invalid Email";
      } else {
        return null;
      }
    }

    String validateMobile(String value) {
      String patttern = r'(^[0-9]*$)';
      RegExp regExp = new RegExp(patttern);
      if (value.length == 0) {
        return "Mobile is Required";
      } else if (value.length != 10) {
        return "Mobile number must 10 digits";
      } else if (!regExp.hasMatch(value)) {
        return "Mobile Number must be digits";
      }
      return null;
    }

    return Column(
      children: <Widget>[
        new TextFormField(
          initialValue: profiledatalogan[0].name,
          enabled: _isenabled,
          decoration: new InputDecoration(hintText: 'Full Name'),
          keyboardType: TextInputType.text,
          maxLength: 32,
          validator: validateName,
          onSaved: (String val) {
            profiledatalogan[0].name = val;
          },
        ),
        TextFormField(
          initialValue: profiledatalogan[0].principalNricCode,
          enabled: false,
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(hintText: 'Passport Number'),
          maxLength: 16,
          onSaved: (String val) {
            // passport = val;
          },
        ),
        // TextFormField(
        //   initialValue: profiledatalogan[0].,
        //   enabled: _isenabled,
        //   decoration: new InputDecoration(hintText: 'Medical Card Number'),
        //   keyboardType: TextInputType.phone,
        //   maxLength: 10,
        //   validator: validateMobile,
        //   onSaved: (String val) {
        //     medicalcardnumber = val;
        //   },
        // ),
        TextFormField(
          initialValue:
              "${profiledatalogan[0].addressLine1 ?? ""} ${profiledatalogan[0].addressLine2 ?? ""} ${profiledatalogan[0].addressLine3 ?? ""}",
          enabled: _isenabled,
          maxLines: 3,
          decoration: new InputDecoration(hintText: 'Address'),
          maxLength: 255,
          validator: validateName,
          onSaved: (String val) {
            profiledatalogan[0].addressLine1 = val;
          },
        ),
        // Container(
        //     child:
        Row(
          children: <Widget>[
            Expanded(
                child: new TextFormField(
              initialValue: profiledatalogan[0].empSubCity,
              enabled: _isenabled,
              decoration: new InputDecoration(hintText: 'City'),
              maxLength: 16,
              validator: validateName,
              onSaved: (String val) {
                profiledatalogan[0].empSubCity = val;
              },
            )),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: new TextFormField(
                initialValue: profiledatalogan[0].empSubState,
                enabled: _isenabled,
                decoration: new InputDecoration(hintText: 'State'),
                maxLength: 16,
                validator: validateName,
                onSaved: (String val) {
                  profiledatalogan[0].empSubState = val;
                },
              ),
            )
          ],
        ),
        // ),
        new DropdownButton(hint: Text("Nationality"),
            items: nationalityDataMore.map((item) {
              return new DropdownMenuItem(
                child: new Text(item.description.toString()),
                value: item.description.toString(),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _dropNationality = newVal;
                print(newVal);
                profiledatalogan[0].empSubNationality=newVal;
              });
            },
          ),
        // TextFormField(
        //   initialValue: profiledatalogan[0].empSubNationality,
        //   enabled: _isenabled,
        //   decoration: new InputDecoration(hintText: 'Nationality'),
        //   maxLength: 16,
        //   validator: validateName,
        //   onSaved: (String val) {
        //     profiledatalogan[0].empSubNationality = val;
        //   },
        // ),
        TextFormField(
          initialValue: profiledatalogan[0].empSubDob,
          enabled: false,
          keyboardType: TextInputType.datetime,
          decoration: new InputDecoration(hintText: 'DOB'),
          maxLength: 16,
          validator: validateName,
          onSaved: (String val) {
            profiledatalogan[0].empSubDob = val;
          },
        ),
        TextFormField(
          initialValue: profiledatalogan[0].empSubGender,
          enabled: false,
          decoration: new InputDecoration(hintText: 'Gender'),
          maxLength: 16,
          validator: validateName,
          onSaved: (String val) {
            profiledatalogan[0].empSubGender = val;
          },
        ),
        TextFormField(
            initialValue: profiledatalogan[0].empSubEmail,
            enabled: false,
            decoration: new InputDecoration(hintText: 'Email ID'),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
            validator: validateEmail,
            onSaved: (String val) {
              profiledatalogan[0].empSubEmail = val;
            }),
        TextFormField(
            initialValue: profiledatalogan[0].empSubMobNo,
            enabled: _isenabled,
            decoration: new InputDecoration(hintText: 'Mobile Number'),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: validateMobile,
            onSaved: (String val) {
              profiledatalogan[0].empSubMobNo = val;
            }),
        SizedBox(height: 15.0),
        SizedBox(
            width: 300.0,
            height: 50.0,
            child: RaisedButton(
                child: new Text(sendButtonName),
                onPressed: _sendToServer,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)))),
      ],
    );
  }
}
