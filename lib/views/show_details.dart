import 'dart:io';

import 'package:demo_app/models/user.dart';
import 'package:demo_app/services/database.dart';
import 'package:flutter/material.dart';

class ShowDetails extends StatefulWidget {

  String uid;
  String fileName;
  ShowDetails({this.uid});

  @override
  _ShowDetailsState createState() => _ShowDetailsState(uid: uid,fileName: fileName);
}

class _ShowDetailsState extends State<ShowDetails> {

  String uid;
  String fileName;
  _ShowDetailsState({this.uid,this.fileName});

  File _imageFile;

  void _openImagePicker(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Container(
          height: 150.0,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text("")
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.blueAccent,
                    child: ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: (_imageFile == null)
                            ? Image.network(
                          userData.photoUrl,
                          fit: BoxFit.fill,
                        )
                            : Image.file(_imageFile, fit: BoxFit.fill),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: FlatButton.icon(
                    onPressed: (){
                      _openImagePicker(context);
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text(""),
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                    "Your UID: ${uid}",
                ),
                SizedBox(height: 15.0,),
                Text(
                    "Your UserName: ${userData.name}",
                ),
                SizedBox(height: 15.0,),
                Text(
                    "Your Phone Number: ${userData.phoneNo}",
                ),
                SizedBox(height: 15.0,),
                Text(
                    "Your Registration No. : ${userData.regNo}",
                ),
                SizedBox(height: 15.0,),
                Text(
                    "Your Branch : ${userData.branch}",
                ),
                SizedBox(height: 15.0,),
                Text(
                    "Your Gender : ${userData.gender}",
                ),
                SizedBox(height: 15.0,),
              ],
            ),
          );
        }
      },
    );
  }
}
