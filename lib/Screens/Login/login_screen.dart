import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/Login/components/body.dart';
import 'package:following_the_prophet/appbar.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var name;
  LoginScreen(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyAppBar(),
                ));
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.green[400],
        title: Center(child: Text('')),
      ),
      body: Body(name),
    );
  }
}
