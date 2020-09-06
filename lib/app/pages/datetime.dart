import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mco/app/components/pagenavigator.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => new _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Page'),
      ),
      body: new Center(
        child: new RaisedButton(
            child: new Text('Goto'),
            onPressed: () {
              Navigator.push(
                context,
                new MyCustomRoute(builder: (context) => new SecondPage()),
              );
            }),
      ),
    );
  }
}

// You can subclass MaterialPageRouteand override buildTransitions.

// Eg:

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => new _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second Page'),
      ),
      body: new Center(
        child: new Text('This is the second page'),
      ),
    );
  }
}
