import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:following_the_prophet/Screens/Login/login_screen.dart';
import 'package:following_the_prophet/Screens/Signup/components/verify.dart';
import 'package:following_the_prophet/components/already_have_an_account_acheck.dart';
import 'package:following_the_prophet/components/rounded_button.dart';
import 'package:following_the_prophet/components/rounded_input_field.dart';
import 'package:following_the_prophet/components/rounded_password_field.dart';
import 'package:following_the_prophet/helper/database.dart';
import 'package:following_the_prophet/helper/firebaseAuth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _prefs = SharedPreferences.getInstance();

  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  Database _db = Database();

  Firebase_Auth _firebase_auth = Firebase_Auth();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: Colors.green[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "UserName",
                  controller: userController,
                ),
                RoundedInputField(
                  hintText: "Your Email",
                  controller: emailController,
                ),
                RoundedPasswordField(
                  controller: passwordController,
                ),
                RoundedButton(
                  text: "SIGN UP",
                  press: () {
                    _signUP();
                  },
                  color: Colors.green[400],
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen("Login");
                        },
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                )
              ],
            ),
          );
  }

  void _signUP() async {
    SharedPreferences prefs = await _prefs;

    setState(() {
      loading = true;
    });
    try {
      Map<String, dynamic> userDataMap = {
        "username": userController.text,
        'email': emailController.text,
        'lastRead': "",
        'favorite': [
          '',
        ],
      };

      await _firebase_auth
          .signUpWithEmail(emailController.text, passwordController.text)
          .then((value) async {
        if (value != null) {
          _db.uploadUserInfo(userDataMap);
          try {
            //to set local user;
            prefs.setString('username', userController.text);
          } catch (e) {
            print(e);
          }
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Verify()));
        } else {
          Fluttertoast.showToast(msg: 'Couldn\'t sign up');
          loading = false;
        }
      });
    } on FirebaseAuthException catch (e) {
      print("Exception " + e.toString());
    }
  }
}
