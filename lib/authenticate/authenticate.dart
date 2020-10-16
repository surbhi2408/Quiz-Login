import 'package:demo_app/authenticate/signin.dart';
import 'package:demo_app/authenticate/signup.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/services/auth.dart';

class Authenticate extends StatefulWidget {

  final String uid;
  Authenticate({this.uid});

  @override
  _AuthenticateState createState() => _AuthenticateState(uid: id);
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  final String uid;
  _AuthenticateState({this.uid});

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }
    else{
      return SignUp(toggleView: toggleView);
    }
  }
}
