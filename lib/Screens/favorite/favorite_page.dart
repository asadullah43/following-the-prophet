import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/eventViewPage.dart';
import 'package:following_the_prophet/appbar.dart';
import 'package:following_the_prophet/helper/database.dart';
import 'package:following_the_prophet/models/User.dart';
import 'package:following_the_prophet/models/contentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  UserModel user;

  FavoritePage({Key key, this.user}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
        title: Text('FavoritePage'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
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
              child: Container(
                height: MediaQuery.of(context).size.height * (0.75),
                child: (widget.user == null || widget.user.username == null)
                    ? Container(
                        child: Center(
                          child: Text("Login first"),
                        ),
                      )
                    : (widget.user.favorite == null ||
                            widget.user.favorite[0] == '')
                        ? Container(
                            child: Center(
                              child: Text("No Favorites"),
                            ),
                          )
                        : /*child:*/ ListView.builder(
                            itemCount: widget.user.favorite.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      getDataAndRoute(
                                          widget.user.favorite[index]);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          (0.90),
                                      decoration: BoxDecoration(
                                          color: Colors.brown,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        leading: Text("${index + 1}"),
                                        title:
                                            Text(widget.user.favorite[index]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              );
                            },
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
          fromEvent: false,
          data: data,
        ),
      ),
    );
  }
}
