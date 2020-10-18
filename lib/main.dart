import 'package:demo_app/models/user.dart';
import 'package:demo_app/services/auth.dart';
import 'package:demo_app/views/signin.dart';
import 'package:demo_app/views/student_home.dart';
import 'package:demo_app/views/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignIn(),
    );
  }
}
