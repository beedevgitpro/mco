import 'package:flutter/material.dart';

import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/models/bulletin_model.dart';

class BulletinsDetailPage extends StatelessWidget {
  BulletinsDetailPage(this.bulletinspage);
  final BulletinData bulletinspage;
  @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        backgroundColor: leadingColor,
        title: new Text(bulletinspage.bulletinTitle),
      ),
      bottomNavigationBar: BottomNavBar(activeTabNumber: 1,),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                // color: Colors.red,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1 / 4,
                  color: leadingColor,
                ),
              ),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5 / 10,
              bottom: MediaQuery.of(context).size.height * 0.5 / 10,
              left: 10.0,
              right: 10.0,
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    bulletinspage.bulletinDescription,
                    style: TextStyle(color: headerFontColor,fontSize: 20),
                  ),
                ),
              )),
        ],
      ));

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: new Container(
              width: 150.0,
              height: 150.0,
              child: Icon(Icons.account_balance),),
        ),
        Container(
          child: Text(
            "${bulletinspage.bulletinTitle}",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 20.0),
          ),
        ),
        SizedBox(height: 30.0),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "${bulletinspage.bulletinDescription}",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}
