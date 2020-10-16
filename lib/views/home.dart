import 'package:demo_app/authenticate/authenticate.dart';
import 'package:demo_app/services/auth.dart';
import 'package:demo_app/views/student_profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  final String uid;

  Home({this.uid});

  @override
  _HomeState createState() => _HomeState(uid: id);
}

class _HomeState extends State<Home> {

  //final AuthService _auth = AuthService();
  final String uid;
  _HomeState({this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await signOut();
              googleSignOut().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (_){
                  return Authenticate();
                }
              )));
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.people),
            label: Text('Profile'),
            onPressed: () async{
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => StudentProfile(uid: id,),
              ));
            },
          ),
        ],
      ),
    );
  }
}
