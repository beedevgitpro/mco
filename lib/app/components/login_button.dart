import 'package:flutter/material.dart';

import 'appbar.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  LoginButton({this.onPressed});
  
	@override
  Widget build(BuildContext context) {
		return new Container(
			margin: const EdgeInsets.symmetric(vertical: 12.0),
			child: new RaisedButton(
        shape: buttonCircularshape,
				color: Theme.of(context).primaryColor,
				child: Padding(
          padding: EdgeInsets.symmetric(vertical:15),
                  child: new Text(
				  	'Log In',
				  	style: new TextStyle(
				  		color: Colors.white,
              fontSize: 18
				  	)
				  ),
				),
				onPressed: onPressed
			)
		);
  }
}
