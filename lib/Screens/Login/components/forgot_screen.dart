import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:following_the_prophet/Screens/Login/login_screen.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email = "";
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF645647),
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Center(child: Text('Reset Password')),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, left: 0),
            width: 350,
            height: 80,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  // filled: true,
                  contentPadding: const EdgeInsets.fromLTRB(12, 15, 20, 15),
                  hintText: 'Enter Your Email',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  )),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 26.0),
                child: TextButton(
                  child: Center(
                    child: Text(
                      'Send Request',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  onPressed: () {
                    print("presss");
                    sendMail(_email);
                    // showAlertDialog(context);
                  },
                  //color: Colors.green[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  sendMail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: _email);
      showAlertDialog(context);
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
          msg: error.message ?? '', gravity: ToastGravity.CENTER_LEFT);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen("Login")),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Forgot Password"),
      content: Text("We've sent an email to $_email for reset password"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
