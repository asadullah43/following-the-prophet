import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/Login/components/body.dart';

class LoginScreen extends StatelessWidget {
  var name;
  LoginScreen(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('')),
      ),
      body: Body(name),
    );
  }
}
