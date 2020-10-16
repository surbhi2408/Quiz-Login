import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/models/user.dart';
import 'package:demo_app/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demo_app/services/auth.dart';

class StudentProfile extends StatefulWidget {

  final String uid;

  StudentProfile({this.uid});

  @override
  _StudentProfileState createState() => _StudentProfileState(uid: id);
}

class _StudentProfileState extends State<StudentProfile> {

  final String uid;
  _StudentProfileState({this.uid});

  final _formKey = GlobalKey<FormState>();
  final List<String> gender = ['Female', 'Male', 'Others'];
  //GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  //String nickName = name;

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
          photoUrl = newImageDownloadUrl;
          Firestore.instance.collection("users").document(id).updateData({
            "photoUrl": photoUrl,

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

  String id;
  String name;
  String phoneNo;
  String photoUrl;
  String regNo;
  String branch;
  String studentGender;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: id).users_data,
      builder: (context,snapshot){
        //print("user id: ${id}");
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                    "Update your info..",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 25,),
                SizedBox(height: 15,),

                // profile picture of user
                Container(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        (imageFileAvatar == null)
                            ? (photoUrl != "")
                            ? Material(
                          child: CachedNetworkImage(
                            // displaying already existing image file
                            placeholder: (context,url) => Container(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(20.0),
                            ),
                            imageUrl: photoUrl,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(125.0)),
                          clipBehavior: Clip.hardEdge,
                        )
                            : Icon(
                          Icons.account_circle,
                          size: 90.0,
                          color: Colors.grey,
                        )
                            : Material(
                          // displaying the new updated image here
                          child: Image.file(
                            imageFileAvatar,
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(125.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            size: 100.0,
                            color: Colors.white54.withOpacity(0.3),
                          ),
                          onPressed: getImage,
                          padding: EdgeInsets.all(0.0),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.grey,
                          iconSize: 200.0,
                        ),
                      ],
                    ),
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.all(20.0),
                ),

                // Image.network(_googleSignIn.currentUser.photoUrl,height: 100.0, width: 100.0,),
                // Text(_googleSignIn.currentUser.displayName),

                // input fields with details of user
                TextFormField(
                  initialValue: userData.name,
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
                SizedBox(height: 15,),
                TextFormField(
                  initialValue: userData.phoneNo,
                  decoration: InputDecoration(hasFloatingPlaceholder: true),
                  validator: (input){
                    if(input.isEmpty){
                      return "Please enter your phone number";
                    }
                  },
                  onChanged: (val){
                    setState(() {
                      phoneNo = val;
                    });
                  },
                ),
                SizedBox(height: 15,),
                Text("gender"),
                DropdownButtonFormField(
                  value: studentGender,
                  items: gender.map((gen){
                    return DropdownMenuItem(
                      value: gen,
                      child: Text('$gen'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => studentGender = val),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  initialValue: userData.regNo,
                  decoration: InputDecoration(hasFloatingPlaceholder: true),
                  validator: (input){
                    if(input.isEmpty){
                      return "Please enter your registration number";
                    }
                  },
                  onChanged: (val){
                    setState(() {
                      regNo = val;
                    });
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  initialValue: userData.branch,
                  decoration: InputDecoration(hasFloatingPlaceholder: true),
                  validator: (input){
                    if(input.isEmpty){
                      return "Please enter your branch";
                    }
                  },
                  onChanged: (val){
                    setState(() {
                      branch = val;
                    });
                  },
                ),
                SizedBox(height: 15.0,),
                FlatButton(
                  child: Text("Update"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: id).updateUserData(
                          name ?? userData.name,
                          phoneNo ?? userData.phoneNo,
                          photoUrl ?? userData.photoUrl,
                          regNo ?? userData.regNo,
                          branch ?? userData.branch,
                          studentGender ?? userData.gender,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        }
        else{
          return Container(
              child: Text('you got an error'),
          );
        }
      },
    );
  }
}
