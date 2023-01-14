import 'package:flutter/material.dart';
import 'package:fud_chatapp/view/forgetpassword.dart';
import 'package:fud_chatapp/view/signin.dart';
import 'package:fud_chatapp/view/signup.dart';

class Authenticate extends StatefulWidget {

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}

