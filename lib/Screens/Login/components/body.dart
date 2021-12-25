import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:following_the_prophet/Screens/Login/components/background.dart';
import 'package:following_the_prophet/Screens/Login/components/forgot_screen.dart';
import 'package:following_the_prophet/Screens/Signup/signup_screen.dart';
import 'package:following_the_prophet/appbar.dart';
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
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var _prefs = SharedPreferences.getInstance();

  Firebase_Auth _firebase_auth = Firebase_Auth();
  Database _db = Database();

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
        : Background(
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold,fontSize: 40),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    controller: emailController,
                    hintText: "Your Email",
                  ),
                  RoundedPasswordField(
                    controller: passwordController,
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                      _signIn();
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20,),
                  //for forgot pass
                            GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResetScreen(),
                                        ),
                                      );
                                    });
                                  },
                                  child: const Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                ],
              ),
            ),
          );
  }

  void _signIn() async {
    SharedPreferences prefs = await _prefs;

    setState(() {
      loading = true;
    });
    await _firebase_auth
        .signInWithEmail(emailController.text, passwordController.text)
        .then(
          
      (value) async {
        if (value != null) {
          try {
            String username = await _db.getUsername(emailController.text);
            prefs.setString('username', username);
          }on FirebaseAuthException catch (error) {
            Fluttertoast.showToast(msg: error.message??'',gravity: ToastGravity.TOP);
           // print(e);
          }
          loading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyAppBar(),
            ),
          );
        } else {
          Fluttertoast.showToast(msg: 'Couldn\'t sign in');
          loading = !loading;
          setState(() {});
        }
      },
    );
  }
}
