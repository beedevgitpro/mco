import 'dart:async';

import 'package:flutter/material.dart';
import 'package:highlighter_coachmark/highlighter_coachmark.dart';
import 'package:http/http.dart' as http;

import 'featuremodel.dart';

class FriendsListPage extends StatefulWidget {
  @override
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  List<Friend> _friends = [];
  GlobalKey _fabKey = GlobalObjectKey("fab");

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadFriends() async {
    http.Response response =
        await http.get('https://randomuser.me/api/?results=5');

    setState(() {
      _friends = Friend.allFromResponse(response.body);
    });

    // Here is how you can launch CoachMark.
    // Management of coach mark tutorials is another topic not covered in this lib
    Timer(Duration(seconds: 1), () => showCoachMarkFAB());
  }

  //Here is example of CoachMark usage
  void showCoachMarkFAB() {
    CoachMark coachMarkFAB = CoachMark();
    RenderBox target = _fabKey.currentContext.findRenderObject();

    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = Rect.fromCircle(
        center: markRect.center, radius: markRect.longestSide * 0.6);

    coachMarkFAB.show(
        targetContext: _fabKey.currentContext,
        markRect: markRect,
        children: [
          Center(
              child: Text("Tap on button\nto add a friend",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  )))
        ],
        duration: null,
    );
  }

  //And here is example of CoachMark usage.
  //One more example you can see in FriendDetailsPage - showCoachMarkBadges()


  @override
  Widget build(BuildContext context) {
    Widget content;
    return Scaffold(
      appBar: AppBar(title: Text('Friends')),
      body: content,
      floatingActionButton: _friends.isEmpty
          ? null
          : FloatingActionButton(
              key: _fabKey,
              child: Icon(Icons.add),
              onPressed: () async {
                Friend friend = await buildShowDialog(context);
                if (friend != null) {
                  setState(() {
                    _friends.add(friend);
                  });
                  
                }
              },
            ),
    );
  }



  void _navigateToFriendDetails(Friend friend, Object avatarTag) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (c) {
    //       return FriendDetailsPage(friend, avatarTag: avatarTag);
    //     },
    //   ),
    // );
  }

  Future<Friend> buildShowDialog(BuildContext context) {
    return showDialog<Friend>(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder<Friend>(
              future: _loadRandomFriend(),
              builder: (BuildContext context, AsyncSnapshot<Friend> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
             
                } else {
                  return SimpleDialog(
                      title: Container(
                          height: 100.0,
                          width: 200.0,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: CircularProgressIndicator()));
                }
              });
        });
  }

  Future<Friend> _loadRandomFriend() async {
    http.Response response =
        await http.get('https://randomuser.me/api/?results=1');
    var friends = Friend.allFromResponse(response.body);
    return friends.first;
  }


}
