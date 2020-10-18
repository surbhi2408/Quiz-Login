// import 'package:demo_app/services/auth.dart';
// import 'package:demo_app/shared/loading.dart';
// import 'package:flutter/material.dart';
//
// class SignUp extends StatefulWidget {
//
//   final Function toggleView;
//   SignUp({this.toggleView});
//
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//
//   final _formKey = GlobalKey<FormState>();
//   String email = '';
//   String password = '';
//   String error = '';
//   //AuthService _auth = new AuthService();
//   bool loading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return loading ? Loading() : Scaffold(
//       appBar: AppBar(
//         title: Text("Register Your account to QuizBox"),
//         centerTitle: true,
//       ),
//       body: Form(
//         key: _formKey,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             children: [
//               Spacer(),
//               TextFormField(
//                 validator: (val) => val.isEmpty ? "Enter email Id" : null,
//                 decoration: InputDecoration(
//                     hintText: "Email",
//                   icon: Icon(Icons.email),
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     email = val;
//                   });
//                 },
//               ),
//               SizedBox(height: 6,),
//               TextFormField(
//                 obscureText: true,
//                 validator: (val) => val.length < 6 ? "Enter valid Password with at least 6 character" : null,
//                 decoration: InputDecoration(
//                     hintText: "Password",
//                   icon: Icon(Icons.lock),
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     password = val;
//                   });
//                 },
//               ),
//               SizedBox(height: 24,),
//               GestureDetector(
//                 onTap: () async{
//                   if(_formKey.currentState.validate()){
//                     setState(() {
//                       loading = true;
//                     });
//                     dynamic result = await registerWithEmailAndPassword(email, password);
//                     if(result == null){
//                       setState(() {
//                         error = "please enter valid email";
//                         loading = false;
//                       });
//                     }
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 18),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width - 48,
//                   child: Text(
//                     "Sign Up",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 6,),
//               Text(
//                 error,
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 14.0,
//                 ),
//               ),
//               SizedBox(height: 2,),
//               GestureDetector(
//                 onTap: (){
//
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 18),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width - 48,
//                   child: Text(
//                     "Sign Up with google",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 18,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Already have an account? ",
//                     style: TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       widget.toggleView();
//                     },
//                     child: Text(
//                       "Sign In",
//                       style: TextStyle(
//                         fontSize: 16,
//                         decoration: TextDecoration.underline,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 80,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
