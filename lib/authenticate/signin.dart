import 'package:demo_app/services/auth.dart';
import 'package:demo_app/shared/loading.dart';
import 'package:demo_app/views/home.dart';
import 'package:demo_app/views/student_profile.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  //final AuthService _auth = AuthService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text("Login to QuizBox"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter email Id" : null,
                decoration: InputDecoration(
                  hintText: "Email",
                  icon: Icon(Icons.email),
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.length < 6 ? "Enter valid Password with at least 6 character" : null,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                  icon: Icon(Icons.lock),
                ),
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 24,),
              GestureDetector(
                onTap: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = "could not sign in with those credentials";
                        loading = false;
                      });
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                      "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6,),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 2,),
              GestureDetector(
                onTap: (){
                  gogleSignIn().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (_){
                        return StudentProfile();
                      })));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                    "Sign In with google",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.toggleView();
                    },
                    child: Text(
                        "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80,),
            ],
          ),
        ),
      ),
    );
  }
}
