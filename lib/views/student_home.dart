import 'package:demo_app/main.dart';
import 'package:demo_app/services/auth.dart';
import 'package:demo_app/views/images.dart';
import 'package:demo_app/views/show_details.dart';
import 'package:demo_app/views/update_info.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {

  String uid;
  StudentHome({this.uid});

  @override
  _StudentHomeState createState() => _StudentHomeState(uid: uid);
}

class _StudentHomeState extends State<StudentHome> {

  String uid;
  _StudentHomeState({this.uid});

  void _updateInfo(context, uid){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return SingleChildScrollView(
          child: Container(
            height: 1000,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingForm(uid: uid),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to QuizBox"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async{
            googleSignOut().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (_){
                return MyApp();
              }
              )));
            },
            icon: Icon(Icons.power_settings_new),
            label: Text('SignOut'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //ImagesInput(),
            SizedBox(height: 15.0,),
            ShowDetails(uid: uid,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mode_edit),
        onPressed: () => _updateInfo(context, uid),
      ),
    );
  }
}
