import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/authenticate/authenticate.dart';
import 'package:demo_app/models/user.dart';
import 'package:demo_app/services/auth.dart';
import 'package:demo_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {

  final String uid;

  Home({this.uid});

  @override
  _HomeState createState() => _HomeState(uid: id);
}

class _HomeState extends State<Home> {

  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final List<String> gender = ['Female', 'Male', 'Others'];

  final String uid;
  _HomeState({this.uid});

  String id;
  String name;
  String phoneNo;
  String photoUrl;
  String regNo;
  String branch;
  String studentGender;

  File imageFileAvatar;

  Future getImage() async{
    File newImagefile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      this.imageFileAvatar = newImagefile;
    });

    uploadImageToFireStoreAndStorage();

  }

  uploadImageToFireStoreAndStorage() async{
    String mFileName = id;
    StorageReference storageReference = FirebaseStorage.instance.ref().child(mFileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(imageFileAvatar);
    StorageTaskSnapshot storageTaskSnapshot;
    storageUploadTask.onComplete.then((value) {
      if(value.error != null){
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl){
          imageUrl = newImageDownloadUrl;
          Firestore.instance.collection("users").document(id).updateData({
            "photoUrl": imageUrl,

          }).then((data) async{

          });
        }, onError: (errorMsg){
          print(errorMsg.toString());
        });
      }
    }, onError: (errorMsg){
      print(errorMsg.toString());
    });
  }

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
          // FlatButton.icon(
          //   icon: Icon(Icons.people),
          //   label: Text('Profile'),
          //   onPressed: () async{
          //     Navigator.push(context, MaterialPageRoute(
          //       builder: (context) => StudentProfile(uid: id,),
          //     ));
          //   },
          // ),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context,AsyncSnapshot<FirebaseUser> snapshot){
          if(snapshot.hasData){
            //UserData userData = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(height: 40.0,),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data.photoUrl,
                        ),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(height: 30,),
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                        "Name: ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40.0,right: 40.0),
                        child: TextFormField(
                          initialValue: snapshot.data.displayName,
                          decoration: InputDecoration(hasFloatingPlaceholder: true),
                          validator: (input){
                            if(input.isEmpty){
                              return "Please enter your name";
                            }
                          },
                          onChanged: (val){
                            setState(() {
                              name = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                        "phone Number: ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40.0,right: 40.0),
                        child: TextFormField(
                          initialValue: snapshot.data.displayName,
                          decoration: InputDecoration(hasFloatingPlaceholder: true),
                          validator: (input){
                            if(input.isEmpty){
                              return "Please enter your phone No.";
                            }
                          },
                          onChanged: (val){
                            setState(() {
                              phoneNo = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Text(
                        "Registration Number: ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40.0,right: 40.0),
                        child: TextFormField(
                          //initialValue: Us,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
