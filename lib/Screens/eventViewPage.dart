import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:following_the_prophet/helper/database.dart';
import 'package:following_the_prophet/models/contentModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'GalleryPage.dart';

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
  bool isLoading = false;
  @override
  void initState() {
    favButtonColor = Colors.white;
    if (widget.fromEvent) {
      isLoading = true;
      getData();
    }
    getUserName();
    super.initState();
  }

  var favButtonColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.data.title)),
        ),
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Details:",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * (0.70),
                      child: ListView(
                        children: [Text(widget.data.details,style: TextStyle(
                          fontSize: 16,
                        ),)],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
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
                            color: Colors.red[100],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  GalleryPage(widget.data.title),
                            ));
                          },
                          icon: Icon(Icons.collections,
                          size: 35,
                          color: Colors.lightBlueAccent,),
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
              ),
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

  isFav() async {
    if (await db.checkFav(widget.data.title, username)) {
      favButtonColor = Colors.red[100];
    } else {
      favButtonColor = Colors.red[100];
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

  getUserName() async {
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
      isLoading = !isLoading;
    });
  }
}
