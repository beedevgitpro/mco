import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final bool obscureText;
  final String passwordError;
  final VoidCallback togglePassword;
  PasswordField({
	  this.passwordController,
	  this.obscureText,
	  this.passwordError,
	  this.togglePassword
  });
  bool isLarge(context){
    print(MediaQuery.of(context).size.width);
    if(MediaQuery.of(context).size.width>350)
      return true;
    return false;
  }
	@override
  Widget build(BuildContext context) {
		return new Container(
			margin: const EdgeInsets.only(bottom: 0),
			child: new Theme(
				data: new ThemeData(
					primaryColor: Theme.of(context).primaryColor,
					textSelectionColor: Theme.of(context).primaryColor
				),
				child: new TextField(
					controller: passwordController,
					obscureText: obscureText,
					decoration: new InputDecoration(
						errorText: passwordError,
						contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
						labelText: 'Your Password',
						suffixIcon: new GestureDetector(
							onTap: togglePassword,
							child: new Icon(Icons.remove_red_eye),
						)
					)
				)
			)
		);
  }
	
}