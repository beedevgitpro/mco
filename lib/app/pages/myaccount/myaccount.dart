import 'package:flutter/material.dart';
import 'package:mco/app/colors.dart';
import 'package:mco/app/components/appbar.dart';
import 'package:mco/app/components/bottomnavbar.dart';
import 'package:mco/app/components/pagenavigator.dart';

import 'myaccount_method.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var copies = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: leadingColor,
        title: Text("My Account"),
      ),
      bottomNavigationBar: BottomNavBar(activeTabNumber: 2,),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: ListView.builder(
            itemCount: choices.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                onTap: () {
                  Navigator.push(context,
                      MyCustomRoute(builder: (context) => choices[i].pageName));
                },
                leading: Icon(choices[i].icon),
                title: Text(choices[i].data,style: Styles.detailsCategoryText,),
                trailing: (choices[i].title == '')
                    ? Icon(choices[i].icontrail)
                    : Text(choices[i].title),
              );
            },
          ),
        ),
      ),
    );
  }
}
