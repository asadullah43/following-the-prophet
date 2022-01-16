import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/sentrequest.dart';
import 'package:following_the_prophet/appbar.dart';

class RequestForData extends StatelessWidget {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _discription = new TextEditingController();

  bool isloading = false;

  submit(context) {
    if (_titleController.text == "" || _discription.text == "") {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Field Required"),
              content: Text("All field is required"),
            );
          });
    }
    if (_titleController.text.length < 2 || _discription.text.length < 2) {
      if (_titleController.text.length < 2) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("oho!"),
                content: Text("Title must be 2 character long"),
              );
            });
      } else if (_discription.text.length < 2) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("oho!"),
                content: Text("Description must be 2 character long"),
              );
            });
      }
    }
    FirebaseFirestore.instance.collection('UserrequestedData').add({
      "Topic": _titleController.text,
      "Description": _discription.text,
      "Uid": FirebaseAuth.instance.currentUser.uid,
      "status": "pending",
      "email": FirebaseAuth.instance.currentUser.email,
      "Main": "",
    }).catchError((e) {
      print(e);
      print(12);
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => request()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF645647),
        appBar: AppBar(
          title: Text('Request For Data',
            style: TextStyle(
              color: Color(0xFFFD9727),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
           backgroundColor: Color(0xFF645647),
        ),
        body: isloading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : WillPopScope(
                onWillPop: () {
                  return Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyAppBar()),
                  );
                },
                child: ListView(children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Topic",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFD9727),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                controller: _titleController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:  BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   child: Text(
                      //     "Description:",
                      //     style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.amberAccent,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.fromLTRB(24, 5, 24, 10),
                        child: TextFormField(
                          maxLines: 25,
                          minLines: 15,
                          decoration: InputDecoration(
                            hintText: "Details",
                            enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: Colors.white,
                              ),

                            ),
                          ),
                          controller: _discription,
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(50, 16, 50, 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        textStyle: TextStyle(),
                        backgroundColor: Color(0xFFFD9727),
                      ),
                      onPressed: () {
                        //print(2);
                        submit(context);
                      },
                      child: Text(
                        "Send Request",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
              ));
  }
}
