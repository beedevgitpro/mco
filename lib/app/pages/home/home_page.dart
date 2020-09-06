import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mco/app/components/animationIcons.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/pages/aboutus/about_us.dart';
import 'package:mco/app/pages/bulletin/Bulletin_page.dart';
import 'package:mco/app/pages/clinic/clinic_list_search.dart';
import 'package:mco/app/pages/faq/faq.dart';
import 'package:mco/app/pages/hospital/hospital_list_search.dart';
import 'package:mco/app/pages/login/login_page.dart';
import 'package:mco/app/pages/myaccount/myaccount.dart';
import 'package:mco/app/pages/setting/settings.dart';
import 'package:mco/app/pages/updatepassword/update_password.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:mco/app/utils/network_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:highlighter_coachmark/highlighter_coachmark.dart';

class HomePage extends StatefulWidget {
  static final String routeName = 'home';

  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferences _sharedPreferences;
  var _authToken, _id, _name, _homeResponse, userid;

  @override
  void initState() {
    super.initState();
    _fetchSessionAndNavigate();
  }
  List<BottomNavigationBarItem> navBarItems=[
    BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home")),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text("Account")),
    BottomNavigationBarItem(icon: Icon(Icons.info),title: Text("About")),
    BottomNavigationBarItem(icon: Icon(Icons.settings),title: Text("Settings")),
  ];
  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    int passwordChange = AuthUtils.getIsPasswordChange(_sharedPreferences);
    userid=AuthUtils.getUserId(_sharedPreferences);
    // var name = _sharedPreferences.getString(AuthUtils.nameKey);
    print("$authToken authToken   $passwordChange  passwordChange ");
    if (passwordChange != 1 ||passwordChange ==null) {
      Navigator.push(context,
          MyCustomRoute(builder: (BuildContext context) => UpdatePassword()));
    }
      // _fetchHome(authToken);      //change uncomment

      setState(() {
        _authToken = authToken;
        // _id = id;
        // _name = name;
      });

      if (_authToken == null) {
        _logout();
      }
    
  }
  _logout() {
    NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
    getLogOutCall(userid);
  }


  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Confirm Exit'),
            content: Text('Are you sure you want to exit PRAassist?'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "No",style: TextStyle(color:Colors.red,fontSize: 18,fontWeight: FontWeight.bold)),
                ),
              ),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(" Yes ", style: TextStyle(color:Color(0xFF2d50ce),fontSize: 18,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ) ??
        false;
  }

var text = new RichText(
  text: new TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: new TextStyle(
      fontSize: 25.0,
      color: Colors.black,
    ),
    children: <TextSpan>[
      new TextSpan(text: 'PRA',style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
      new TextSpan(text: 'assist', style: new TextStyle(fontWeight: FontWeight.bold,color:whiteColor)),
    ],
  ),
 );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: text,
    backgroundColor: leadingColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                color: whiteColor,
                icon: Icon(Icons.exit_to_app,size: 30),
                onPressed: () => _logout(),
                tooltip: "Logout",
              ),
            )
          ],
        ),
        bottomNavigationBar:BottomNavBar(activeTabNumber: 1,),
        body: buildContainerDashboard(context),
      ),
    );
  }
}

Container buildContainerDashboard(BuildContext context) {
  return Container(
    color: Colors.indigo[50].withOpacity(0.6),
    // padding: EdgeInsets.symmetric(vertical: 20.0,),
    child: GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(3.0),
      children: <Widget>[
        makeDashboardItem(
            "Book Hospital", EvaIcons.thermometerPlus, HospitalPage(), context),
        // makeDashboardItem("Book Hospital", Icons.local_library,MapView(),context),
        makeDashboardItem(
            "Book Clinic", Icons.local_hospital, ClinicPage(), context),
        makeDashboardItem(
            "My Account", Icons.account_box, MyAccount(), context),
        makeDashboardItem("Settings", Icons.settings, Setting(), context),
        makeDashboardItem(
            "Bulletins", Icons.library_books, BulletinPage(), context),
        makeDashboardItem("FAQ", Icons.question_answer, Faq(), context),
        makeDashboardItem("About", Icons.info, AboutUs(), context),
      ],
    ),
  );
}

Widget makeDashboardItem(
    String title, IconData icon, Widget stl, BuildContext context) {
  return Container(
    height: 100,
    width: 50,
    child: Card(
        elevation: 3.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white54,
              // color: Colors.indigo.shade300,
          border: Border.all(color: Colors.grey.withOpacity(0.5))),
          child: new InkWell(
            onTap: () {
              Navigator.push(
                  context, MyCustomRoute(builder: (BuildContext context) => stl));
            },
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisSize: MainAxisSize.min,
              // verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                    icon, size: 35.0,
                    // color: Colors.white
                    color: Colors.indigo.shade400,
                  ),
                
                SizedBox(height: 20.0),
                 new Text(title,
                      style: new TextStyle(
                          fontSize: 18.0,
                          // color: Colors.white
                          color:headerFontColor,
                          fontWeight: FontWeight.bold)),
                
              ],
            ),
          ),
        )),
  );
}
