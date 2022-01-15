import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        //Color(0xFF645647),
        title: Center(child: Text('')),
      ),
      body: Body(),
    );
  }
}
