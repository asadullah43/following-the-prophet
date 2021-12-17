// ignore_for_file: file_names, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import "package:image_picker/image_picker.dart";

import 'package:path/path.dart' as path;

class SendData extends StatefulWidget {
  const SendData({Key key}) : super(key: key);

  @override
  _SendDataState createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _detailController = new TextEditingController();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
              title: Center(child: Text("Insert Data")),
            ),
            body: isloading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Title",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                        color: Colors.amberAccent,

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
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            Container(
                              child: Text(
                                "Details:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amberAccent,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: TextFormField(
                                maxLines: 10,
                                minLines: 10,
                                decoration: InputDecoration(
                                  hintText: "Details",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                ),
                                controller: _detailController,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 16, 50, 0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            textStyle: TextStyle(),
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            setState(
                              () {},
                            );
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )));
  }
}
