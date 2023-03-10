import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:following_the_prophet/helper/database.dart';
import 'package:following_the_prophet/models/contentModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'GalleryPage.dart';

// ignore: must_be_immutable
class EventViewScreen extends StatefulWidget {
  ContentModel data;
  bool fromEvent = false;
  EventViewScreen({Key key, this.data, this.fromEvent}) : super(key: key);
  @override
  _EventViewScreenState createState() => _EventViewScreenState();
}

class _EventViewScreenState extends State<EventViewScreen> {
  Database db = Database();
  String username;
  double fontSize = 16;
  bool isLoading = false;

  increaseFontSize() {
    print(fontSize);
    if (fontSize > 26) {
      this.fontSize = fontSize;
    } else {
      this.fontSize = fontSize + 2;
    }
    setState(() {});
  }

  decreaseFontSize() {
    print(fontSize);
    if (fontSize < 16) {
      this.fontSize = fontSize;
    } else {
      this.fontSize = fontSize - 2;
    }
    setState(() {});
  }

  getEver() async {
    isLoading = true;
    await getUserName();

    if (username != null) await isFav();
  }

  bool _isInit = true;
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    if (_isInit) {
      try {
        await getEver();
        if (widget.fromEvent) {
          await getData();
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e);
      }
    }
    setState(() {
      isLoading = false;
    });
    _isInit = false;

    super.didChangeDependencies();
  }

  var favButtonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF645647),
          title: !isLoading
              ? Text(
                  widget.data.title,
                  style: TextStyle(
                    color: Color(0xFFFD9727),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(""),
        ),
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : widget.data != null
                ? Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text(
                                "Details:",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xFFFD9727),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      increaseFontSize();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      decreaseFontSize();
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ))
                              ],
                            )
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * (0.70),
                          child: ListView(
                            children: [
                              Text(
                                widget.data.details,
                                style: TextStyle(
                                  fontSize: fontSize,
                                ),
                              )
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 60,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _openYoutube();
                              },
                              child: Icon(
                                FontAwesomeIcons.youtube,
                                size: 40,
                                color: Colors.red[400],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      GalleryPage(widget.data.title),
                                ));
                              },
                              icon: Icon(
                                Icons.collections,
                                size: 35,
                                color: Colors.lightBlueAccent[400],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _favMethod();
                              },
                              icon: Icon(
                                Icons.favorite,
                                size: 30.0,
                                color: favButtonColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Center(child: Container(child: Text("No event"))),
      ),
    );
  }

  @override
  void dispose() async {
    if (username != null) {
      await db.addLastRead(widget.data.title, username);
    }
    super.dispose();
  }

  void _openYoutube() async {
    var url = "${widget.data.youtubeLink}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could not launch $url");
      throw 'Could not launch $url';
    }
  }

  Future isFav() async {
    if (await db.checkFav(widget.data.title, username)) {
      favButtonColor = Colors.red;
    } else {
      favButtonColor = Colors.white;
    }
    setState(() {});
  }

  _favMethod() async {
    if (username == null) {
      Fluttertoast.showToast(msg: 'Login');
    } else {
      var result = await db.addFav(widget.data.title, username);
      setState(() {
        if (result) {
          favButtonColor = Colors.red[100];
        } else
          favButtonColor = Colors.white;
      });
    }
    setState(() {});
  }

  Future getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
  }

  getData() async {
    var docs = await db.dataByTitle(widget.data.title);
    widget.data = ContentModel(
      title: docs[0].data()['title'],
      subtitle: docs[0].data()['subtitle'],
      year: docs[0].data()['year'],
      details: docs[0].data()['details'],
      youtubeLink: docs[0].data()['youtubeLink'],
      image: docs[0].data()['images'],
    );
    setState(() {
      isLoading = false;
    });
  }
}
