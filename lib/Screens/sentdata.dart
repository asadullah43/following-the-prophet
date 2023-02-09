import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:following_the_prophet/Screens/sentdataview.dart';
import 'package:following_the_prophet/appbar.dart';

class Sent extends StatefulWidget {
  static final routeName = 'CrimeRecord';

  @override
  State<Sent> createState() => _SentState();
}

class _SentState extends State<Sent> {
  final stream = FirebaseFirestore.instance
      .collection('usersentcontent')
      .where("Uid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .snapshots();
  var name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF645647),
        title: FittedBox(
            child: Text(
          'My Content',
          style: TextStyle(
            color: Color(0xFFFD9727),
          ),
        )),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyAppBar()),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.search),
                ),
                SizedBox(
                  width: 10,
                ), //
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20, right: 10),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (val) => setState(() {
                        name = val;
                      }),
                      decoration: InputDecoration(
                        fillColor: Colors.blueAccent[50],
                        filled: true,
                        labelText: 'Search by Title ',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        labelStyle:
                            TextStyle(fontSize: 16.0, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: stream,
                  builder: (context, snp) {
                    if (snp.hasError) {
                      print(snp);
                      return Center(
                        child: Text("No Data is here"),
                      );
                    } else if (snp.hasData || snp.data != null) {
                      return snp.data.docs.length < 1
                          ? Center(child: Container(child: Text("No Record")))
                          : ListView.builder(
                              itemCount: snp.data.docs.length,
                              itemBuilder: (ctx, i) => Container(
                                  child: name != ""
                                      ? (snp.data.docs[i].data()
                                                  as Map)["title"]
                                              .toString()
                                              .toLowerCase()
                                              .contains(
                                                  name.toString().toLowerCase())
                                          ? Viewdataview(snp.data.docs[i])
                                          : Container()
                                      : Viewdataview(snp.data.docs[i])));
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
