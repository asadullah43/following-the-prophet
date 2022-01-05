// // ignore_for_file: file_names, prefer_const_constructors

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import "package:image_picker/image_picker.dart";

// import 'package:path/path.dart' as path;
// import 'package:file_picker/file_picker.dart';

// class SendData extends StatefulWidget {
//   const SendData({Key key}) : super(key: key);

//   @override
//   _SendDataState createState() => _SendDataState();
// }

// class _SendDataState extends State<SendData> {
//   TextEditingController _titleController = new TextEditingController();
//   TextEditingController _detailController = new TextEditingController();

//   bool isloading = false;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Center(child: Text("Insert Data")),
//         ),
//         body: isloading
//             ? Container(
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               )
//             : ListView(
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     child: Column(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.all(15),
//                           padding: EdgeInsets.all(8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Title",
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.amberAccent,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Expanded(
//                                 child: TextField(
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                   ),
//                                   controller: _titleController,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 17,
//                         ),
//                         Container(
//                           child: Text(
//                             "Details:",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.amberAccent,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.all(15),
//                           child: TextFormField(
//                             maxLines: 10,
//                             minLines: 10,
//                             decoration: InputDecoration(
//                               hintText: "Details",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             controller: _detailController,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         ElevatedButton(
//                           child: Text('Pick File'),
//                           onPressed: () async {
//                             FilePickerResult result =
//                                 await FilePicker.platform.pickFiles();

//                             if (result != null) {
//                               File file = File(result.files.single.path);
//                             } else {
//                               // User canceled the picker
//                             }
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(50, 16, 50, 0),
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                         padding: const EdgeInsets.all(16.0),
//                         textStyle: TextStyle(),
//                         backgroundColor: Colors.blue,
//                       ),
//                       onPressed: () {
//                         setState(
//                           () {},
//                         );
//                       },
//                       child: Text(
//                         "Submit",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

// ignore_for_file: file_names, prefer_const_constructors

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
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(20),
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
                                  width: 12,
                                ),
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    controller: _titleController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(15),
                              padding: EdgeInsets.all(20),
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
                                          color: Colors.blue,
                                        ),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.redAccent,
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
                                    width: 40,
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
                            height: 17,
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextFormField(
                              minLines: 1,
                              maxLines: 10,
                              //expands: true,
                              decoration: InputDecoration(
                                hintText: "Details",
                                border: OutlineInputBorder(),
                              ),
                              controller: _detailController,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(8),
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
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    controller: _linkController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Image:",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.amber,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.upload_rounded,
                                  color: Colors.blue,
                                ),
                                onTap: () {
                                  print("tapped");
                                  getImages();
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              uploadToFireStore();
                              setState(() {
                                isloading = true;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(15),
                              width: 130,
                              height: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue.shade300,
                              ),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: 17,
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
