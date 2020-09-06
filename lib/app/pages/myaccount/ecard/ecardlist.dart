import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/constants.dart';
import 'package:mco/app/pages/hospital/hospital_presenter.dart';
import 'package:mco/app/pages/myaccount/ecard/ecardmethods.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ecarddetail.dart';
import 'ecardmodel.dart';

class EcardList extends StatefulWidget {
  EcardList({Key key}) : super(key: key);

  @override
  _EcardListState createState() => _EcardListState();
}

class _EcardListState extends State<EcardList> {
  final ecardApi = EcardApiRepository();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String authToken, userProfileCode;
  SharedPreferences _sharedPreferences;
  bool submitting = false;

  List<McoCardDetail> ecardApidata = [];
  // List<McoCardDetail> ecardApidatalogan = [];

  Future validateLogin() async {
    _sharedPreferences = await _prefs;
    authToken = AuthUtils.getToken(_sharedPreferences);
    userProfileCode = AuthUtils.getUserProfileCode(_sharedPreferences);

    ecardApidata = await ecardApi.getUserCardFromProfileCode(
        authToken, submitting, getEcardApi, userProfileCode);
    setState(() {
      // ecardApidatalogan = ecardApidata;
    });
  }

  @override
  void initState() {
  
    super.initState();
    validateLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leadingColor,
        title: Text("View Cards"),
      ),
      bottomNavigationBar: BottomNavBar(activeTabNumber: 2,),
      body: RefreshIndicator(
        onRefresh: validateLogin,
              child: ListView.builder(
          itemCount: ecardApidata.length,
          itemBuilder: (BuildContext context, int i) {
              return Padding(
          padding: EdgeInsets.only(left:15,right:15,bottom: 5),
                child: Card(
            shape: listItemShape,
            elevation: listElevation,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                      leading: LeadingLetter(ecardApidata[i].name),
                      onTap: () {
                        Navigator.push(
                            context,
                            MyCustomRoute(
                                builder: (context) =>
                                    EcardDetail(ecardApidata[i])));
                      },
                      contentPadding: EdgeInsets.all(10),
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                                              child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(ecardApidata[i].policyNo,style: listPageTitleStyle),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (ecardApidata[i].relationshipCheck == 1)
                                ? Text("Principal",style: listPageTitleStyle)
                                :
                                (ecardApidata[i].relationshipCheck == 2)
                                ? Text("Dependent",style: listPageTitleStyle)
                                :Text("Spouse",style: listPageTitleStyle),
                          Text(ecardApidata[i].policyName,style:TextStyle(color: secondaryFontColor) ,),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_right)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
