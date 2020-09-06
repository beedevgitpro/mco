//testing

import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';
import 'package:mco/app/models/bulletin_model.dart';
import 'package:mco/app/pages/hospital/hospital_methods.dart';
import 'package:mco/app/pages/hospital/hospital_presenter.dart';
import 'package:mco/app/pages/login/Loader.dart';
import 'package:mco/app/utils/auth_utils.dart';
import 'package:mco/app/utils/network_utils.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';
import '../../constants.dart';
import 'bulletindetail.dart';

enum TabItem { home, bulletin, account, about, setting }

class BulletinPage extends StatefulWidget {
  @override
  _BulletinPageState createState() => new _BulletinPageState();
}

class _BulletinPageState extends State<BulletinPage> {
  TabItem currentTab = TabItem.bulletin;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  SharedPreferences _sharedPreferences;

  String _searchText = "";
  List<BulletinData> names = new List<BulletinData>();
  List<BulletinData> filteredNames = new List<BulletinData>();
  Icon _searchIcon = new Icon(Icons.search);
  static String appTitle = 'Bulletins List';
  Widget _appBarTitle = new Text(appTitle);
  bool submitting = false;
  var _authToken;
  bool nodata = false;

  Future fetchSessionAndNavigate() async {
    List<BulletinData> response = [];
    print(
      "inside ${response.length}",
    );
    _sharedPreferences = await _prefs;
    String authToken = AuthUtils.getToken(_sharedPreferences);
    // var id = _sharedPreferences.getInt(AuthUtils.userIdKey);
    // var name = _sharedPreferences.getString(AuthUtils.nameKey);
    // print(authToken);
    // _fetchHome(authToken); //change uncomment
    response = await getNamesBulletins(authToken, submitting, bulletinsUrl);
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
    _authToken = authToken;
    // _id = id;
    setState(() {
      // _name = name;
    });

    if (_authToken == null) {
      NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
    }
  }

  _BulletinPageState() {
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
      appBar: buildBar(context),
      // bottomNavigationBar: MyBottomBar( currentTab),
      bottomNavigationBar: BottomNavBar(activeTabNumber: 1,),
      body: new Center(
        child: submitting
            ? new Container(
                padding: EdgeInsets.all(8.0),
                child: nodata
                    ? Text("No Records",
                        style: TextStyle(color: secondaryBoldFontColor))
                    : RefreshIndicator(
                        onRefresh: fetchSessionAndNavigate,
                        child: _buildList()),
              )
            : ColorLoader4(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      backgroundColor: leadingColor,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        alignment: Alignment.center,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List<BulletinData> tempList = new List<BulletinData>();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .bulletinTitle
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
            child: card(index, context));
      },
    );
  }

  // return card(index, context);

  Card card(int index, BuildContext context) {
    return Card(
      shape: listItemShape,
      elevation: listElevation,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: new ListTile(
          leading: LeadingLetter(filteredNames[index].bulletinTitle),
          trailing: Icon(
            Icons.arrow_right,
            color: leadingColor,
          ),
          title: Text(filteredNames[index].bulletinTitle,
              style: listPageTitleStyle),
          onTap: () {
            Navigator.push(
                context,
                new MyCustomRoute(
                    builder: (BuildContext context) =>
                        new BulletinsDetailPage(filteredNames[index])));
          },
        ),
      ),
    );
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
            // prefixIcon: new Icon(Icons.search),
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
          ),
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
