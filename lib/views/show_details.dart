import 'dart:io';
import 'package:demo_app/models/user.dart';
import 'package:demo_app/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

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

  Future _getImage(BuildContext context,ImageSource source) async{
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image){
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  Future uploadPic(BuildContext context) async {
    fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    
    setState(() {
      print("Profile Picture Uploaded");
      print(_imageFile);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded'),));
    });
  }

  void _openImagePicker(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Container(
          height: 150.0,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                "Pick an Image",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              FlatButton(
                child: Text(
                  "Use Camera",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: (){
                  _getImage(context, ImageSource.camera);
                },
              ),
              SizedBox(height: 5.0,),
              FlatButton(
                onPressed: (){
                  _getImage(context, ImageSource.gallery);
                },
                child: Text(
                  "From Gallery",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              )
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
                Align(
                  alignment: Alignment.topCenter,
                  child: FlatButton(
                    child: Text("ADD PHOTO"),
                    onPressed: (){
                      uploadPic(context);
                    },
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
        else{
          return Container(child: Text("You got an error"),);
        }
      },
    );
  }
}
