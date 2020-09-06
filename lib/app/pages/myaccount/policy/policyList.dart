import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mco/alert.dart';
import 'package:mco/app/colors.dart';
import 'package:mco/app/components/animationAlert.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/pages/hospital/hospital_presenter.dart';
import 'package:mco/app/pages/myaccount/policy/policymodel.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stretchy_header/stretchy_header.dart';
import '../../../constants.dart';
import 'policymethods.dart';

class PolicyList extends StatefulWidget {
  @override
  _PolicyListState createState() => _PolicyListState();
}

class _PolicyListState extends State<PolicyList> {
  final policyapi = PolicyApiRepository();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String authToken, userProfileCode;
  SharedPreferences _sharedPreferences;
  bool submitting = false;
  // List<PolicyPlanDetails> policydata = new List<PolicyPlanDetails>();
  List<GetPolicyDetails> policydata = [];
  List<GetPolicyDetails> policydatalogan = [];
  Future validateLogin() async {
    _sharedPreferences = await _prefs;
    authToken = AuthUtils.getToken(_sharedPreferences);
    userProfileCode = AuthUtils.getUserProfileCode(_sharedPreferences);
    policydata = await policyapi.getUserPolicyFromProfileCode(
        authToken, submitting, getPoliciesApi, userProfileCode);
    print(policydata[0]);

    setState(() {
      policydatalogan = policydata;
    });
  }
  bool isLarge(context){
    print(MediaQuery.of(context).size.width);
    if(MediaQuery.of(context).size.width>350)
      return true;
    return false;
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
        title: Text("View Policy"),
      ),
      bottomNavigationBar: BottomNavBar(activeTabNumber: 2,),
      body: RefreshIndicator(
        onRefresh: validateLogin,
        child: ListView.builder(
          itemCount: policydata.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: Card(
                shape: listItemShape,
                elevation: listElevation,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    // dense: true,
                    leading: LeadingLetter(policydata[i].policyNo),
                    onTap: () {
                      Navigator.push(
                          context,
                          MyCustomRoute(
                              builder: (context) =>
                                  PolicyDetailPage(policydata[i])));
                    },
                    contentPadding: EdgeInsets.all(10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(policydata[i].policyNo, style: listPageTitleStyle),
                      ],
                    ),
                    subtitle: Text(policydata[i].policyHolderName,
                        style: TextStyle(color: secondaryFontColor)),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      //       body: AnimatedListViewScroll(
      //   itemCount: policy.length,
      //   itemHeight: 60,
      //   animationOnReverse: true,
      //   animationDuration: Duration(milliseconds: 200),
      //   itemBuilder: (context, index) {
      //     return AnimatedListViewItem(
      //       key: GlobalKey(),
      //       index: index,
      //       animationBuilder: (context, index, controller) {
      //         Animation<Offset> animation =
      //             Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
      //                 .animate(controller);
      //         return SlideTransition(
      //           position: animation,
      //           child: Card(
      //             child: Text(policy[index].policyName),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}

class PolicyDetailPage extends StatelessWidget {
  GetPolicyDetails policydetail;
  PolicyDetailPage(this.policydetail);
  bool isLarge(context){
    print(MediaQuery.of(context).size.width);
    if(MediaQuery.of(context).size.width>350)
      return true;
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: leadingColor,
          title: Text(policydetail.policyHolderName),
        ),
        bottomNavigationBar:BottomNavBar(activeTabNumber: 2,),
        body: Container(
          // color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Container(
                  color: secondaryFontColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Policy Details :",
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                PolicyRow(
                  policydetail.policyNo,
                  "Policy Number:",
                ),
                PolicyRow(
                  policydetail.policyType,
                  "Plan type:",
                ),
                PolicyRow(
                  policydetail.coverageStartDate,
                  "Start Coverage:",
                ),
                PolicyRow(
                  policydetail.coverageEndDate,
                  "End Coverage:",
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  color: secondaryFontColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Beneficiaries :",
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      // height: 10,
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 8.0, right: 8.0),
                          title: buildTextpolicy(
                              context, policydetail.policyHolderName),
                          trailing: buildTextpolicy(context, "Principal"),
                          onTap: () {
                            _modalBottomSheetMenu(context, policydetail);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 1 / 6,
                      child: ListView.builder(
                        itemCount: policydetail.dependent.length,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.all(8.0),
                              title: buildTextpolicy(context,
                                  policydetail.dependent[i].policyHolderName),
                              trailing:
                                  policydetail.dependent[i].isPrincipal == 2
                                      ? buildTextpolicy(context, "Dependent")
                                      : buildTextpolicy(context, "Spouse"),
                              onTap: () {
                                _modalBottomSheetMenu(context, policydetail, i);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

Text buildTextpolicy(
  BuildContext context,
  String string,
) {
  return Text(
    string,
    style: Theme.of(context).textTheme.display1.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 15.0,
        color: secondaryBoldFontColor),
    textAlign: TextAlign.start,
  );
}

Widget _modalBottomSheetMenu(
    BuildContext _context, GetPolicyDetails policydetail,
    [int i]) {
  showModalBottomSheet(
      context: _context,
      builder: (builder) {
        return new Container(
          height: 150.0,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Column(
                children: <Widget>[
                  Container(
                    color: secondaryFontColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Extra Details :",
                            style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  i == null
                      ? PolicyRow(
                          policydetail.policyHolderName,
                          "Policy Name:",
                        )
                      : PolicyRow(
                          policydetail.dependent[i].policyHolderName,
                          "Policy Name:",
                        ),
                  i == null
                      ? PolicyRow(
                          policydetail.overallLimit,
                          "Annual Limit:",
                        )
                      : PolicyRow(
                          policydetail.dependent[i].overallLimit,
                          "Annual Limit:",
                        ),
                  i == null
                      ? PolicyRow(
                          policydetail.utilisedAmount,
                          "Utilized Amount:",
                        )
                      : PolicyRow(
                          policydetail.dependent[i].utilisedAmount,
                          "Utilized Amount:",
                        ),
                ],
              )),
        );
      });
}

class PolicyRow extends StatelessWidget {
  final policydetail;
  final String constString;
  PolicyRow(this.policydetail, this.constString);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              constString,
              style: Theme.of(context).textTheme.display1.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: secondaryBoldFontColor),
            ),
            Text(
              "$policydetail",
              style: Theme.of(context).textTheme.display1.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: secondaryBoldFontColor),
            ),
          ]),
    );
  }
}
