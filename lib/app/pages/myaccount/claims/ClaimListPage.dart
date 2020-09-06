//testing

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/pages/hospital/hospital_methods.dart';
import 'package:mco/app/pages/login/Loader.dart';
import 'package:mco/app/pages/myaccount/claims/claimsmodel.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:mco/app/utils/network_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import 'claimslistpresenter.dart';

class ClaimListPage extends StatefulWidget {
  // ClaimListPage({ Key key }) : super(key: key);
  @override
  _ClaimListPageState createState() => new _ClaimListPageState();
}

class _ClaimListPageState extends State<ClaimListPage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  SharedPreferences _sharedPreferences;
  final _focusNode = FocusNode();
  String _searchText = "";
  List<GetClaims> names = new List<GetClaims>();
  List<GetClaims> filteredNames = new List<GetClaims>();
  Icon _searchIcon = new Icon(Icons.search);
    static String appTitle ='Claims List';

  Widget _appBarTitle = new Text(appTitle);
  bool submitting = false;
  bool nodata = false;

  var _authToken;
  Future fetchSessionAndNavigate() async {
    // submitting = false;
        List<GetClaims> response = [];

    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
     String  userProfileCode= AuthUtils.getUserProfileCode(_sharedPreferences);

    response = await getClaims(
      authToken,
      submitting,
      getClaimsApi,
      userProfileCode
    );
    setState(() {
      names = response;
      filteredNames = names;
      if (filteredNames.isEmpty) {
        submitting = true;
        nodata=true;
      }
      else{
        submitting=true;
      }
      // else
    });
    setState(() {
      _authToken = authToken;
    });
    if (_authToken == null) {
      NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
    }
      // }
    // });

  }

  _ClaimListPageState() {
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
      bottomNavigationBar: BottomNavBar(activeTabNumber: 2,),
      appBar: buildBars(context),
      body: new Center(
        child: nodata?Text("No Records",style:TextStyle(color:secondaryBoldFontColor ) ): 
        RefreshIndicator(
          onRefresh: fetchSessionAndNavigate,
          child: submitting
              ? new Container(
                  child: _buildList(),
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
      // actions: <Widget>[
      //   Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: IconButton(
      //         icon: Icon(Icons.map),
      //         onPressed: () {
      //           // Navigator.push(
      //           //     context,
      //           //     new MyCustomRoute(
      //           //         builder: (BuildContext context) =>
      //           //             Map_View_Hospital("Hospital", names)));
      //         },
      //       ))
      // ],
      leading: new IconButton(
        icon: _searchIcon,
        alignment: Alignment.center,
        onPressed: searchPressed,
      ),
    );
  }

  Widget _buildList() {
    if (_searchText.isNotEmpty) {
      List<GetClaims> tempList = new List<GetClaims>();
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
    return listViewClaims(names, filteredNames);
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
