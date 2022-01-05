import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:following_the_prophet/Screens/Login/login_screen.dart';

class Verify extends StatefulWidget {
  //const Verify({ Key key }) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;
  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkEmailVerifed();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AlertDialog(
      content: Text(
          "An email has been sent to ${user.email} please Verify your email"),
    )
            // child: Text("An email has been sent to ${user.email} please Verify your email "),
            ));
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerifed() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Fluttertoast.showToast(
          msg: "Account created successfully :", gravity: ToastGravity.CENTER);
      Navigator.of(this.context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen("Login")));
    }
  }
}
