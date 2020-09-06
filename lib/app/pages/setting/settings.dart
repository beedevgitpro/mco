import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/pages/faq/faq.dart';
import 'package:mco/app/pages/myaccount/myaccount.dart';
import 'package:mco/app/pages/myaccount/myaccount_method.dart';
import 'package:mco/app/pages/privacypolicy/privacy_policy.dart';
import 'package:mco/app/pages/profile/profile.dart';
import 'package:mco/app/pages/termsandcondition/termsandconditions.dart';
import 'package:mco/app/pages/updatepassword/update_password.dart';

import '../../colors.dart';

List<Choice> settingList = <Choice>[
  // Choice(
  //     data: "Update Profile",
  //     icon: Icons.person,
  //     icontrail: Icons.arrow_right,
  //     pageName: Profile()),
  Choice(
      data: "Update Password",
      icon: Icons.lock,
      icontrail: Icons.arrow_right,
      pageName: UpdatePassword()),
  Choice(
      data: "Privacy Policy",
      icon: Icons.book,
      icontrail: Icons.arrow_right,
      pageName: PrivacyPolicy()),
  Choice(
      data: "FAQ",
      icon: Icons.question_answer,
      icontrail: Icons.arrow_right,
      pageName: Faq()),
  Choice(
      data: "Terms and Conditions",
      icon: Icons.library_books,
      icontrail: Icons.arrow_right,
      pageName: TermAndConditions()),
];

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leadingColor,
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            // child: buildListView(context)
            child: ListView.builder(
          itemCount: settingList.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              leading: Icon(settingList[i].icon),
              trailing: Icon(settingList[i].icontrail),
              title: Text(settingList[i].data,style: Styles.detailsCategoryText,),
              onTap: () => {
                    Navigator.push(
                      context,
                      MyCustomRoute(
                          builder: (context) => settingList[i].pageName),
                    )
                  },
            );
          },
        )),
      ),
      bottomNavigationBar: BottomNavBar(activeTabNumber: 4,),
    );
  }
}
