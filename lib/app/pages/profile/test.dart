// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:geo/app/pages/profile/empnationalitymodel.dart';
// import 'package:geo/app/pages/profile/empstatesmodel.dart' as prefix0;
// import 'package:geo/app/pages/profile/profilemethods.dart';

// import 'empstatesmodel.dart';

// class MyAppState extends StatefulWidget {
//   @override
//   __MyAppStateState createState() => __MyAppStateState();
// }

// class __MyAppStateState extends State<MyAppState> {

//   final profilerepo = ProfileRepository();

//   List<GetNationality> data = [];
//     List<GetNationality> datamore = [];

//   // List<EmpState>  data =List<Statecode>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     functsd();
//   }

//   functsd() async {
//     data = await profilerepo.getNationality();
//     print(data[0].description);
//     setState(() {
//       datamore=data;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text("Hospital Management"),
//       ),
//       body: new Center(
//           child: new DropdownButton(
//             items: data.map((item) {
//               return new DropdownMenuItem(
//                 child: new Text(item.description.toString()),
//                 value: item.description.toString(),
//               );
//             }).toList(),
//             onChanged: (newVal) {
//               setState(() {
//                 _mySelection = newVal;
//                 print(_mySelection);
//               });
//             },
//             value: _mySelection,
//           ),
//           ),
//     );
//   }
// }
