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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Reset Password')),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            width: 350,
            height: 80,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                child: Text('Send Request',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  print("presss");

                  sendMail(_email);
                  // showAlertDialog(context);
                },
                color: Colors.blue,
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
          MaterialPageRoute(builder: (context) => LoginScreen()),
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
