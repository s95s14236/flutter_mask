import 'package:flutter/material.dart';
import 'package:order/screens/authenticate/register.dart';
import 'package:order/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      print('showSignIn');
      return SignIn(toggleView: toggleView);
    } else {
      print('showRegister');
      return Register(toggleView: toggleView);
    }
  }
}
