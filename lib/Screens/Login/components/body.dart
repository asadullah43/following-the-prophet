import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:following_the_prophet/Screens/Login/components/background.dart';
import 'package:following_the_prophet/Screens/Login/components/forgot_screen.dart';
import 'package:following_the_prophet/Screens/SendDataFile.dart';
import 'package:following_the_prophet/Screens/Signup/signup_screen.dart';
import 'package:following_the_prophet/Screens/favorite/favorite_page.dart';
import 'package:following_the_prophet/Screens/lastRead/lastRead.dart';
import 'package:following_the_prophet/Screens/requestForData.dart';
import 'package:following_the_prophet/Screens/sentdata.dart';
import 'package:following_the_prophet/Screens/sentrequest.dart';
import 'package:following_the_prophet/appbar.dart';
import 'package:following_the_prophet/components/already_have_an_account_acheck.dart';
import 'package:following_the_prophet/components/rounded_button.dart';
import 'package:following_the_prophet/components/rounded_input_field.dart';
import 'package:following_the_prophet/components/rounded_password_field.dart';
import 'package:following_the_prophet/helper/database.dart';
import 'package:following_the_prophet/helper/firebaseAuth.dart';
import 'package:following_the_prophet/models/User.dart';
import 'package:following_the_prophet/models/contentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  var name;
  Body(this.name);
}

class _BodyState extends State<Body> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var _prefs = SharedPreferences.getInstance();
  getUserData(String username) async {
    var result = await FirebaseFirestore.instance
        .collection('userContent')
        .where('username', isEqualTo: username)
        .get()
        .catchError((e) {
      print(e);
    });

    return result.docs[0].data();
  }

  void navigate() async {
    switch (widget.name) {
      case "request":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => request()),
        );
        break;
      case "SendData":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SendData()),
        );
        break;

      case "RequestForData":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RequestForData()),
        );
        break;
      case "sent":
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => sent()),
        );
        break;
      case "Fav":
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var username = prefs.getString('username');
        var dbData = await getUserData(username);
        UserModel userdata = UserModel(
            username: dbData['username'],
            email: dbData['email'],
            lastRead: dbData['lastRead'],
            favorite: dbData['favorite']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FavoritePage(
              user: userdata,
            ),
          ),
        );
        break;
      case "LastRead":
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var username = prefs.getString('username');
        var dbData = await getUserData(username);
        UserModel userdata = UserModel(
            username: dbData['username'],
            email: dbData['email'],
            lastRead: dbData['lastRead'],
            favorite: dbData['favorite']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LastReadPage(userdata)),
        );
        break;
      default:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyAppBar()),
        );
    }
  }

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
                    style: TextStyle(
                        color: Colors.green[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
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
                    color: Colors.green[400],
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
                  SizedBox(
                    height: 20,
                  ),
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
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        color: Colors.green[400],
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
    try {
      var value = await _firebase_auth.signInWithEmail(
          emailController.text, passwordController.text);
      if (value != null) {
        try {
          String username = await _db.getUsername(emailController.text);
          prefs.setString('username', username);
        } on FirebaseAuthException catch (error) {
          Fluttertoast.showToast(
              msg: error.message ?? '', gravity: ToastGravity.BOTTOM);
          // print(e);
          loading = !loading;
          setState(() {});
        }
        loading = false;
        navigate();
      } else {
        Fluttertoast.showToast(msg: 'Couldn\'t sign in');
        loading = !loading;
        setState(() {});
      }
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
          msg: error.message ?? '', gravity: ToastGravity.BOTTOM);
      // print(e);
      loading = !loading;
      setState(() {});
    } catch (error) {
      Fluttertoast.showToast(msg: 'Couldn\'t sign in');
      Fluttertoast.showToast(
          msg: error.message ?? '', gravity: ToastGravity.BOTTOM);
      loading = !loading;
      setState(() {});
    }
  }
}
