//testing

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/models/hospital_model.dart';
import 'package:mco/app/pages/hospital/hospital_methods.dart';
import 'package:mco/app/pages/hospital/hospital_presenter.dart';
import 'package:mco/app/pages/login/Loader.dart';
import 'package:mco/app/pages/mapview_hospital/Map_view_hospital.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:mco/app/utils/network_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class HospitalPage extends StatefulWidget {
  // HospitalPage({ Key key }) : super(key: key);
  @override
  _HospitalPageState createState() => new _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  SharedPreferences _sharedPreferences;
  final _focusNode = FocusNode();
  String _searchText = "";
  List<HospitalData> names = new List<HospitalData>();
  List<HospitalData> filteredNames = new List<HospitalData>();
  Icon _searchIcon = new Icon(Icons.search);
  static String appTitle = 'Hospital List';

  Widget _appBarTitle = new Text(appTitle);
  bool submitting = false;
  var _authToken;
  bool nodata = false;
   bool isLarge(context){
    print(MediaQuery.of(context).size.width);
    if(MediaQuery.of(context).size.width>350)
      return true;
    return false;
  }
  Future fetchSessionAndNavigate() async {
    // submitting = false;
    List<HospitalData> response = [];
    print(
      "inside ${response.length}",
    );
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    response = await getNamesHospital(
      authToken,
      submitting,
      hospitalUrl,
    );
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
    });
    if (_authToken == null) {
      NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
    }
  }

  _HospitalPageState() {
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
    fetchSessionAndNavigate();
    super.initState();
  }

  Widget build(BuildContext context) {
    return buildScaffoldHospital(context);
  }

  Scaffold buildScaffoldHospital(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(activeTabNumber: 1,),
      appBar: buildBars(context),
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

  Widget buildBars(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      backgroundColor: leadingColor,
      actions: <Widget>[
        SizedBox(
            height: 100.0,
            child: IconButton(
              icon: Icon(Icons.map),
              onPressed: () {
                Navigator.push(
                    context,
                    new MyCustomRoute(
                        builder: (BuildContext context) =>
                            Map_View_Hospital("Hospital", names)));
              },
            ))
      ],
      leading: new IconButton(
        icon: _searchIcon,
        alignment: Alignment.center,
        onPressed: searchPressed,
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    if (_searchText.isNotEmpty) {
      List<HospitalData> tempList = new List<HospitalData>();
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
    return listViewHospital(names, filteredNames,isLarge(context));
  }

  void searchPressed() {
    // FocusScope.of(context).requestFocus(_focusNode);
    setStateSearchPressed();
  }

  void setStateSearchPressed() {
    return setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
