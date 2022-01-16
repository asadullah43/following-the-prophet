
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:following_the_prophet/Screens/sentdata.dart';
import 'package:following_the_prophet/appbar.dart';

import "package:image_picker/image_picker.dart";

import 'package:path/path.dart' as path;

class SendData extends StatefulWidget {
  @override
  _SendDataState createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  String subtitle = 'Makki life';

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _detailController = new TextEditingController();

  TextEditingController _linkController = new TextEditingController();
  TextEditingController yearController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController monthController = new TextEditingController();

  final ImagePicker _picker = ImagePicker();

  List<XFile> _imageFileList;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF645647),
        appBar: AppBar(
          backgroundColor: Color(0xFF645647),
          title: Text("Insert Data",style: TextStyle(
            color: Color(0xFFFD9727),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
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
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Container(
                    //   padding: EdgeInsets.only(top: 20),
                    //   margin: EdgeInsets.only(right: 1200),
                    //
                    //   child: GestureDetector(
                    //      onTap: () {
                    //        setState(() {
                    //          Navigator.pushReplacement(
                    //            context,
                    //            MaterialPageRoute(
                    //              builder: (context) => HomePage(),
                    //            ),
                    //          );
                    //        });
                    //      },
                    //      child: Icon(
                    //        Icons.arrow_back,
                    //        color: Colors.blue,
                    //        size: 30.0,
                    //      )
                    //    ),
                    // ),

                    //////////////
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                           // margin: EdgeInsets.fromLTRB(0,0,0,0),
                            //padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Title",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.amber,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    controller: _titleController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
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
                          Container(
                              margin: EdgeInsets.only(top: 12),
                              //padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Subtitle",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      DropdownButton<String>(
                                        value: subtitle,
                                        icon: const Icon(
                                          Icons.arrow_downward,
                                          color: Color(0xFFFD9727),
                                        ),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.black45,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            subtitle = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Ghazwat',
                                          'Makki life',
                                          'Madni life',
                                          'Hijrat',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Year",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: yearController,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Month",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: monthController,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Day",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: dateController,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                           // margin: EdgeInsets.all(15),
                            child: TextFormField(
                              minLines: 1,
                              maxLines: 10,
                              //expands: true,
                              decoration: InputDecoration(
                                hintText: "Details",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              controller: _detailController,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            // margin: EdgeInsets.all(15),
                            // padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Youtube Link",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.amber,
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: TextField(
                                    minLines: 1,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    controller: _linkController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
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
                            height: 15,
                          ),
                          Container(
                            height: _imageFileList == null ? 1 : 50,
                            width: MediaQuery.of(context).size.width - 100,
                            child: _imageFileList == null
                                ? null
                                : ListView.builder(
                                    itemCount: _imageFileList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, position) {
                                      return Container(
                                        margin: EdgeInsets.all(10),
                                        width: 50,
                                        child: Image.file(
                                          File(_imageFileList[position].path),
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    }),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                           // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Image:",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.amber,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.upload_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onTap: () {
                                  print("tapped");
                                  getImages();
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          GestureDetector(
                            onTap: () {
                              uploadToFireStore();
                              setState(() {
                                isloading = true;
                              });
                            },
                            child: Container(
                              //margin: EdgeInsets.all(10),
                              width: 230,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFFD9727),
                              ),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future imagedata(BuildContext context, var imageFIle, String title) async {
    String fileName = path.basename(imageFIle.path);
    var firebaseStorageRef =
        FirebaseStorage.instance.ref().child('$title/$fileName');
    var uploadTask = firebaseStorageRef.putFile(imageFIle);
    var taskSnapshot = await uploadTask.whenComplete(() => null);
    return taskSnapshot.ref.getDownloadURL();
  }

  void uploadToFireStore() async {
    List imageNameList = [];
    if (imagedata != null) {
      if (_imageFileList != null) {
        for (var image in _imageFileList) {
          String title = _titleController.text;
          imageNameList.add(imagedata(context, imagedata, title));
        }
      }
    } else {
      Fluttertoast.showToast(msg: "Please Upload Image its required");
      return;
    }
    uploadContent(
      String title,
      String subtitle,
      int year,
      int month,
      int day,
      String details,
      String youtubeLink,
      List image,
    ) {
      Map<String, dynamic> contentMap = {
        "title": title == "" ? "No Title added" : title,
        "subtitle": subtitle == "" ? "No subtitle added" : subtitle,
        "year": year == 0 ? 0 : year,
        "details": details == "" ? "No details" : details,
        "youtubeLink": youtubeLink == "" ? "No link added" : youtubeLink,
        "image": image,
        "status": "pending",
        "email": FirebaseAuth.instance.currentUser.email,
        "Uid": FirebaseAuth.instance.currentUser.uid,
        "day": day == 0 ? 0 : day,
        'month': month == 0 ? 0 : month,
      };
      FirebaseFirestore.instance
          .collection('usersentcontent')
          .add(contentMap)
          .catchError((e) {
        print(e);
        print(12);
      });
    }

    await uploadContent(
        _titleController.text,
        subtitle,
        int.parse(yearController.text == "" ? "0" : yearController.text),
        int.parse(monthController.text == "" ? "0" : monthController.text),
        int.parse(dateController.text == "" ? "0" : monthController.text),
        _detailController.text,
        _linkController.text,
        imageNameList);

    setState(() {
      isloading = false;
    });
    Fluttertoast.showToast(
        msg: "Data send after approval from admin we will notify you");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => sent()));
  }

  getImages({BuildContext context}) async {
    try {
      final pickedFileList = await _picker.pickMultiImage(
          //imageQuality: quality,
          );
      setState(() {
        _imageFileList = pickedFileList;
      });
    } catch (e) {
      setState(() {
        var _pickImageError = e;
      });
    }
  }
}
