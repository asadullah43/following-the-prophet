import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:following_the_prophet/appbar.dart';
import 'package:following_the_prophet/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatelessWidget {
  final UserModel user;

  UserInfoScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF645647),
          actions: <Widget>[
            PopupMenuButton<int>(
              color: Color(0xFF645647),
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1)),
              //shape: ShapeBorder(),
              onSelected: (item) => handleClick(context),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          title: Text(
            "Signed In",
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "User Name: ",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    user.username,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleClick(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyAppBar()));
  }
}
