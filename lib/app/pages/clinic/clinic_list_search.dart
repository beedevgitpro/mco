//testing

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/models/clinic_model.dart';
import 'package:mco/app/pages/clinic/clinic_presenter.dart';
import 'package:mco/app/pages/hospital/hospital_methods.dart';
import 'package:mco/app/pages/login/Loader.dart';
import 'package:mco/app/pages/mapview_clinic/Map_view_clinic.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:mco/app/utils/network_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class ClinicPage extends StatefulWidget {
  // ClinicPage({ Key key }) : super(key: key);
  @override
  _ClinicPageState createState() => new _ClinicPageState();
}

class _ClinicPageState extends State<ClinicPage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  SharedPreferences _sharedPreferences;

  String _searchText = "";
  List<ClinicData> names = new List<ClinicData>();
  List<ClinicData> filteredNames = new List<ClinicData>();
  Icon _searchIcon = new Icon(Icons.search);
  static String appTitle = 'Clinic List';
  Widget _appBarTitle = new Text(appTitle);
  bool submitting = false;
  var _authToken;
  bool nodata = false;

  Future fetchSessionAndNavigate() async {
    List<ClinicData> response = [];
    print(
      "inside ${response.length}",
    );
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    // var id = _sharedPreferences.getInt(AuthUtils.userIdKey);
    // var name = _sharedPreferences.getString(AuthUtils.nameKey);
    // print(authToken);
    // _fetchHome(authToken); //change uncomment
    response = await getNamesClinic(authToken, submitting, clinicUrl);
    setState(() {
      names = response;
      filteredNames = names;
      if (filteredNames.isEmpty) {
        submitting = true;
        nodata = true;
      } else {
        submitting = true;
      }
    });
    setState(() {
      _authToken = authToken;
      // _id = id;
      // _name = name;
    });

    if (_authToken == null) {
      NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
    }
  }

  _ClinicPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this.fetchSessionAndNavigate();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(activeTabNumber: 1,),
      appBar: buildBar(context),
      body: new Center(
        child: nodata
            ? Text("No Records",
                style: TextStyle(color: secondaryBoldFontColor))
            : RefreshIndicator(
                onRefresh: fetchSessionAndNavigate,
                child: submitting
                    ? new Container(
                        child: _buildList(context),
                      )
                    : ColorLoader4(),
              ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: leadingColor,
      centerTitle: true,
      title: _appBarTitle,
      actions: <Widget>[
        SizedBox(
            height: 100.0,
            child: IconButton(
              tooltip: "Map View",
              icon: Icon(Icons.map),
              onPressed: () {
                Navigator.push(
                    context,
                    new MyCustomRoute(
                        builder: (BuildContext context) =>
                            Map_View_Clinic("Clinic", names)));
              },
            ))
      ],
      leading: new IconButton(
        icon: _searchIcon,
        tooltip: "Search",
        alignment: Alignment.center,
        onPressed: _searchPressed,
      ),
    );
  }
  bool isLarge(context){
    print(MediaQuery.of(context).size.width);
    if(MediaQuery.of(context).size.width>350)
      return true;
    return false;
  }
  Widget _buildList(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      List<ClinicData> tempList = new List<ClinicData>();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return listView(names, filteredNames,isLarge(context));
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          style: TextStyle(color: Colors.white),
          autofocus: true,
          controller: _filter,
          decoration: new InputDecoration(
              fillColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
               borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: UnderlineInputBorder(
               borderSide: BorderSide(color: Colors.white)
              ),
              // prefixIcon: new Icon(Icons.search),
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = Text(appTitle);
        filteredNames = names;
        _filter.clear();
      }
    });
  }
}
