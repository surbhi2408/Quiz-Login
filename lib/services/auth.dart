import 'package:demo_app/models/user.dart';
import 'package:demo_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = new GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

String name = '';
String phoneNo = '';
String imageUrl = '';
String id = '';

Future<String> gogleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
        .authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    AuthResult result = await _auth.signInWithCredential(credential);

    final FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = result.user;
      assert(user.uid == currentUser.uid);
      assert(user.email != null);
      assert(user.uid != null);
      assert(user.displayName != null);
      assert(user.photoUrl != null);
    }

    id = user.uid;
    name = user.displayName;
    phoneNo = user.phoneNumber;
    imageUrl = user.photoUrl;

    await DatabaseService(uid: user.uid).updateUserData(name, phoneNo, imageUrl, "your regNo", "Your branch", "your gender");

    print("Username: ${user.uid}");
    return '${user}';
    //return Future.value(true);
  }
}

Future<void> googleSignOut() async{
  await googleSignIn.signOut();
  print("user signed out");
}

// User _userFromFirebaseUser(FirebaseUser user){
//   return user != null ? User(uid: user.uid) : null;
// }
//
// // get current UID
// Future<String> getCurrentUID() async{
//   final FirebaseUser user = await _auth.currentUser();
//   final String uid = user.uid;
//   return uid;
// }
//
// // get current USER
// Future getCurrentUser() async{
//   return await _auth.currentUser();
// }
//
// // get profile image
// getProfileImage() async{
//   FirebaseUser user = await _auth.currentUser();
//   await user.reload();
//   user = await _auth.currentUser();
//   if(user.photoUrl != null){
//     return NetworkImage(user.photoUrl);
//   }
//   else{
//     return Icon(Icons.account_circle, size: 100,);
//   }
// }
//
// // auth change user stream
// Stream<User> get user{
//   return _auth.onAuthStateChanged
//       .map(_userFromFirebaseUser);
// }
//
// // sign in anonymously
// Future signInAnon() async{
//   try{
//     AuthResult result = await _auth.signInAnonymously();
//     FirebaseUser user = result.user;
//     return _userFromFirebaseUser(user);
//   }catch(e){
//     print(e.toString());
//     return null;
//   }
// }
//
// // sign in with email & password
// Future signInWithEmailAndPassword(String email,String password) async{
//   try{
//     AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
//     FirebaseUser user = result.user;
//
//     return _userFromFirebaseUser(user);
//   }catch(e){
//     print(e.toString());
//     return null;
//   }
// }
//
// // register with email and password
// Future registerWithEmailAndPassword(String email,String password) async{
//   try{
//     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//     FirebaseUser user = result.user;
//
//     // create a new document for the user with the uid
//     // await DatabaseService(uid: user.uid).updateUserData(user.displayName,user.phoneNumber,user.photoUrl,"20184061","CSE","female");
//
//     return _userFromFirebaseUser(user);
//   }catch(e){
//     print(e.toString());
//     return null;
//   }
// }
//
// // sign out
// Future signOut() async{
//   try{
//     return await _auth.signOut();
//   }catch(e){
//     print(e.toString());
//     return null;
//   }
// }


