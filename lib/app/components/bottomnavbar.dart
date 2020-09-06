// import 'package:flutter/material.dart';
// import 'package:mco/app/components/animationIcons.dart';
// import 'package:mco/app/components/pagenavigator.dart';
// import 'package:mco/app/pages/aboutus/about_us.dart';
// import 'package:mco/app/pages/bulletin/Bulletin_page.dart';
// import 'package:mco/app/pages/home/home_page.dart';
// import 'package:mco/app/pages/myaccount/myaccount.dart';
// import 'package:mco/app/pages/setting/settings.dart';

import 'package:flutter/material.dart';

import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/pages/aboutus/about_us.dart';
import 'package:mco/app/pages/bulletin/Bulletin_page.dart';
import 'package:mco/app/pages/home/home_page.dart';
import 'package:mco/app/pages/myaccount/myaccount.dart';
import 'package:mco/app/pages/setting/settings.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({@required this.activeTabNumber});
  final int activeTabNumber;
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // List<BottomNavigationBarItem> navBarItems=[
  //   BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home")),
  //   BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text("Account")),
  //   BottomNavigationBarItem(icon: Icon(Icons.info),title: Text("About")),
  //   BottomNavigationBarItem(icon: Icon(Icons.settings),title: Text("Settings")),
  // ];
  @override
  Widget build(BuildContext context) {
    // return BottomNavigationBar(
    //   items: navBarItems,
    //   currentIndex: _selectedIndex,
    //   selectedItemColor: Colors.white
    // );
    return BottomAppBar(
      child: Container(
        height: 70.0,
        color: leadingColor,
        child: Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
                       Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                      // iconSize: 40,
                      // icon: SvgPicture.asset(
                      //   "lib/app/assets/homeicon.svg",
                      //   color: whiteColor,
                      // ),
                      icon: Icon(Icons.home,color: widget.activeTabNumber==1?Colors.white:Colors.white54,),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MyCustomRoute(builder: (context) => HomePage()),
                          (Route<dynamic> route) => false,
                        );
                      }),
                  tabText("Home",widget.activeTabNumber==1?Colors.white:Colors.white54),
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.account_circle,color: widget.activeTabNumber==2?Colors.white:Colors.white54,),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MyCustomRoute(builder: (context) => MyAccount()));
                      }),
                  tabText("Account", widget.activeTabNumber==2?Colors.white:Colors.white54),
                ],
              ),
              // Column(
              //   mainAxisSize: MainAxisSize.max,
              //   children: <Widget>[
              //     IconButton(
              //         icon: SvgPicture.asset(
              //           "lib/app/assets/bulletionsicon.svg",
              //           color: whiteColor,
              //         ),
              //         onPressed: () {
              //           Navigator.pushReplacement(
              //               context,
              //               MyCustomRoute(
              //                   builder: (context) => BulletinPage()));
              //         }),
              //     tabText("Bulletins", whiteColor),
              //   ],
              // ),
     
              Column(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.info,color: widget.activeTabNumber==3?Colors.white:Colors.white54),
                      tooltip: 'Increase volume by 10',
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MyCustomRoute(builder: (context) => AboutUs()));
                      }),
                  tabText("About", widget.activeTabNumber==3?Colors.white:Colors.white54),
                ],
              ),
              Column(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.settings,color: widget.activeTabNumber==4?Colors.white:Colors.white54,),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MyCustomRoute(builder: (context) => Setting()));
                      }),
                  tabText("Settings", widget.activeTabNumber==4?Colors.white:Colors.white54),
                ],
              ),
            ],
          ),
        ),
      ),
// shape: CircularNotchedRectangle(),
      color: Colors.indigo[200],
    );
  }
}

Widget tabText(
  String text,
  Color color,
) {
  return Text(
    text,
    style: TextStyle(color: color),
  );
}
