import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mco/app/pages/myaccount/claims/ClaimListPage.dart';
import 'package:mco/app/pages/myaccount/ecard/ecardlist.dart';
import 'package:mco/app/pages/myaccount/policy/policyList.dart';
import 'package:mco/app/pages/profile/profile.dart';

class Choice {
  const Choice(
      {this.title, this.icon, this.data, this.icontrail, this.pageName});
  final String title;
  final IconData icon;
  final IconData icontrail;
  final String data;
  final Widget pageName;
}

List<Choice> choices = <Choice>[
  // Choice(
  //     data: "My Profile",
  //     title: '',
  //     icon: Icons.person,
  //     icontrail: Icons.arrow_right,
  //     pageName: Profile()),
  Choice(
      data: "Policy lists",
      title: '',
      icon: Icons.list,
      icontrail: Icons.arrow_right,
      pageName: PolicyList()),
        Choice(
      data: "Your Ecards",
      title: '',
      icon: Icons.card_membership,
      icontrail: Icons.arrow_right,
      pageName: EcardList()),
        Choice(
      data: "Your Claims",
      title: '',
      icon: Icons.get_app,
      icontrail: Icons.arrow_right,
      pageName: ClaimListPage()),

  // Choice(data: "Copies of Medical Cards", title: '4', icon: Icons.date_range),
  // Choice(data: "Policiy Numbers", title: '123456789', icon: Icons.date_range),
  // Choice(data: "Plan Type", title: 'XYZ', icon: Icons.date_range),
  // Choice(
  //     data: "Overall Annual Limit", title: '10000', icon: Icons.attach_money),
  // Choice(data: "Room & Board", title: '7', icon: Icons.room),
  // Choice(data: "Policy", title: '15 Mar, 2020', icon: Icons.date_range),
];

// final dio = new Dio();
// Response response;

// Future<> getNames(
//     String authToken, bool submitting, String url, String recievedData) async {
//   response = await dio.get(url,
//       options: Options(headers: {
//         "Accept": "application/json",
//         'Authorization': 'Bearer $authToken',
//       }));
//   if (response.statusCode == 200) submitting = true;
//   {
//     // List tempList = new List();
//     // for (int i = 0; i < response.data[recievedData].length; i++) {
//     //   tempList.add(response.data[recievedData][i]);
//     // }
//     // return tempList;
//   }
// }

// class MyAccountModel {
//   int copies;
//   int policyNo;
//   int playType;
//   int annualLimit;
//   int roomBoard;
//   List<Policy> policy;
// }

// class Policy {
//   int policyNo;
//   String policyName;
//   int annualLimit;
//   int plantype;
//   int copies;
//   int roomBoard;
//   Policy({this.policyNo, this.policyName, this.annualLimit,this.plantype,this.copies,this.roomBoard});
// }

// List<Policy> policy = <Policy>[
//   Policy(policyNo: 14, annualLimit: 12000, plantype:1, copies:32, roomBoard:1 , policyName: "first policy"),
//   Policy(policyNo: 24, annualLimit: 13000, plantype:1, copies:32, roomBoard:12 , policyName: "second policy"),
//   Policy(policyNo: 34, annualLimit: 14000, plantype:1, copies:32, roomBoard:13 , policyName: "third policy"),
//   Policy(policyNo: 44, annualLimit: 15000, plantype:1, copies:32, roomBoard:14 , policyName: "fourth policy"),
//   Policy(policyNo: 54, annualLimit: 16000, plantype:1, copies:12, roomBoard:11 , policyName: "fifth policy"),
//   Policy(policyNo: 64, annualLimit: 17000, plantype:1, copies:12, roomBoard:12 , policyName: "sixth policy"),
//   Policy(policyNo: 11, annualLimit: 12200, plantype:1, copies:12, roomBoard:14 , policyName: "first policy"),
//   Policy(policyNo: 21, annualLimit: 12300, plantype:1, copies:1 , roomBoard:13 , policyName: "second policy"),
//   Policy(policyNo: 31, annualLimit: 12400, plantype:1, copies:1 , roomBoard:1 , policyName: "third policy"),
//   Policy(policyNo: 41, annualLimit: 12500, plantype:1, copies:12, roomBoard:15 , policyName: "fosurth policy"),
//   Policy(policyNo: 51, annualLimit: 12600, plantype:1, copies:22, roomBoard:51 , policyName: "fifsth policy"),
//   Policy(policyNo: 61, annualLimit: 12700, plantype:1, copies:22, roomBoard:21 , policyName: "sixsth policy"),
//   Policy(policyNo: 11, annualLimit: 12200, plantype:1, copies:12, roomBoard:11 , policyName: "fisrst policy"),
//   Policy(policyNo: 21, annualLimit: 12300, plantype:1, copies:12, roomBoard:31 , policyName: "secsond policy"),
//   Policy(policyNo: 31, annualLimit: 12400, plantype:1, copies:12, roomBoard:41 , policyName: "thisrd policy"),
//   Policy(policyNo: 41, annualLimit: 12500, plantype:1, copies:12, roomBoard:51 , policyName: "fosurth policy"),
//   Policy(policyNo: 51, annualLimit: 12600, plantype:1, copies:12, roomBoard:51 , policyName: "fifsth policy"),
//   Policy(policyNo: 61, annualLimit: 12700, plantype:1, copies:12, roomBoard:61 , policyName: "sixsth policy"),
// ];
