import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';

class TermAndConditions extends StatefulWidget {
  @override
  _TermAndConditionsState createState() => _TermAndConditionsState();
}

class _TermAndConditionsState extends State<TermAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leadingColor,
        title: Text("Terms and Conditions"),
      ),
      body: privacyPolicydetail(),
      bottomNavigationBar: BottomNavBar(activeTabNumber: 4,),
    );
  }
}

Widget privacyPolicydetail() {
  final String content =
      "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button. Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.";

  return Container(
    margin: EdgeInsets.all(20),
    child: ListView(
      children: <Widget>[Text(content,textAlign: TextAlign.justify,), Text(content,textAlign: TextAlign.justify,)],
    ),
  );
}
