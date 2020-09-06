import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'app/components/pagenavigator.dart';
import 'app/pages/home/home_page.dart';

//alert style
var alertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  //descStyle: TextStyle(fontWeight: FontWeight.bold),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.black,
  ),
);

// Alert with message and custom buttons
 onAlertButtonsPressed(
  context,
  AlertType alertType,
  String title,
  String submit,
  String cancel,
  // Function fun,
  // [AlertType afterSavedAlertType,
  // String savedTitle,
  // String savedButton,
  // String savedDescription,
  // String description]
) {
  bool status;
  Alert(
    context: context,
    type: alertType,
    title: title,
    // desc: description,
    buttons: [
      DialogButton(
        child: Text(
          cancel,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          status = false;
          navigatoBack(context);
        },
        color: Colors.red,
      ),
      DialogButton(
        child: Text(
          submit,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          return status = true;
        },
        color: Color(0xFF2d50ce),
        // gradient: LinearGradient(colors: [
        //   Color.fromRGBO(116, 116, 191, 1.0),
        //   Color.fromRGBO(52, 138, 199, 1.0)
        // ]),
      )
    ],
  ).show();
  return status;
}

// The easiest way for creating RFlutter Alert

// Acknowledgement alert message
Widget alertShow(context, String savedTitle, String saveddescription,
    AlertType afterSavedAlertType, String savedButton, bool navigate) {
  Alert(
      context: context,
      title: savedTitle,
      style: alertStyle,
      desc: saveddescription,
      type: afterSavedAlertType,
      buttons: [
        DialogButton(
          child: Text(
            savedButton,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            navigate ? navigatoHome(context) : navigatoBack(context);
          },
          color: Color(0xFF2d50ce),
        )
      ]).show();
}

navigatoBack(BuildContext context) {
  Navigator.pop(context);
}

navigatoHome(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MyCustomRoute(builder: (context) => HomePage()),
    (Route<dynamic> route) => false,
  );
  // Navigator.push(
  //     context, MyCustomRoute(builder: (context) => HomePage()));
}

// onAlertButtonsPressed(
//   context,
//   AlertType.warning,
//   "Are you sure?",
//   "Submit",
// );
