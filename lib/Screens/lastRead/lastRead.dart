import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/eventViewPage.dart';
import 'package:following_the_prophet/appbar.dart';
import 'package:following_the_prophet/helper/database.dart';
import 'package:following_the_prophet/models/User.dart';
import 'package:following_the_prophet/models/contentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LastReadPage extends StatefulWidget {
  UserModel user;

  LastReadPage(this.user);

  @override
  State<LastReadPage> createState() => _LastReadPageState();
}

class _LastReadPageState extends State<LastReadPage> {
  Database _db = Database();
  bool isLoading = true;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavigationMenu(), //to add nav menu here in this page
      appBar: AppBar(
        title: Text(
          'Last Read',
          style: TextStyle(
            color: Color(0xFFFD9727),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF645647),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyAppBar()),
          );
        },
        child: Container(
          child: (widget.user == null || widget.user.username == null)
              ? Container(
                  child: Center(
                    child: Text("Login first"),
                  ),
                )
              : (widget.user.lastRead == '')
                  ? Container(
                      child: Center(
                        child: Text("No Last Read"),
                      ),
                    )
                  : /*child:*/ Container(
                      margin: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width * (0.90),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                        onTap: () {
                          getDataAndRoute(widget.user.lastRead);
                        },
                        child: ListTile(
                          //leading: Text("",style: TextStyle(color: Colors.black),),
                          title: Text(widget.user.lastRead),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var username = prefs.getString('username');
      print("USerName $username");
      if (username != null) {
        var dbData = await _db.getUserData(username);
        print("DBDATA: " + dbData.toString());
        widget.user = UserModel(
            username: dbData['username'],
            email: dbData['email'],
            lastRead: dbData['lastRead'],
            favorite: dbData['favorite']);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = !isLoading;
    });
  }

  getDataAndRoute(String event) async {
    var docs = await _db.dataByTitle(event);
    ContentModel data = ContentModel(
      title: docs[0].data()['title'],
      subtitle: docs[0].data()['subtitle'],
      year: docs[0].data()['year'],
      details: docs[0].data()['details'],
      youtubeLink: docs[0].data()['youtubeLink'],
      image: docs[0].data()['images'],
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventViewScreen(
          data: data,
          fromEvent: false,
        ),
      ),
    );
  }
}
