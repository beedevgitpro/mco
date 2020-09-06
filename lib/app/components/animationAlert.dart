// import 'package:flutter/material.dart';
// import 'package:geo/app/pages/myaccount/policy/policymodel.dart';

// class AlertMsg extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RaisedButton.icon(
//             onPressed: () {
//               OverlayEntry overlayEntry;
//               overlayEntry = OverlayEntry(builder: (c) {
//                 return FunkyOverlay(onClose: () => overlayEntry.remove());
//               });
//               Overlay.of(context).insert(overlayEntry);
//             },
//             icon: Icon(Icons.check),
//             label: Text("Submit!")),
//       ),
//     );
//   }
// }

// class FunkyOverlay extends StatefulWidget {
//   final VoidCallback onClose;

//   const FunkyOverlay({Key key, this.onClose}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => FunkyOverlayState();
// }

// class FunkyOverlayState extends State<FunkyOverlay>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation<double> opacityAnimation;
//   Animation<double> scaleAnimatoin;

//   @override
//   void initState() {
//     super.initState();

//     controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 450));
//     opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
//         CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
//     scaleAnimatoin =
//         CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

//     controller.addListener(() {
//       setState(() {});
//     });

//     controller.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black.withOpacity(opacityAnimation.value),
//       child: Center(
//         child: ScaleTransition(
//           scale: scaleAnimatoin,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: ShapeDecoration(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0))),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: FlatButton(
//                   onPressed: widget.onClose,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Icon(Icons.check),
//                       Text("Form Submitted Successfully"),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

