import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/Login/login_screen.dart';
import 'package:following_the_prophet/Screens/UserInfoScreen.dart';
import 'package:following_the_prophet/Screens/favorite/favorite_page.dart';
import 'package:following_the_prophet/Screens/home/components/quickButton.dart';
import 'package:following_the_prophet/Screens/requestForData.dart';
import 'package:following_the_prophet/helper/database.dart';
import 'package:following_the_prophet/models/User.dart';
import 'package:following_the_prophet/models/contentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Screens/RateUsPage.dart';
import 'Screens/SendDataFile.dart';
import 'Screens/contactUsPage.dart';
import 'Screens/home/components/calender.dart';
import 'Screens/home/components/daily_event.dart';
import 'Screens/lastRead/lastRead.dart';
import 'Screens/settings/settings.dart';

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBar createState() => _MyAppBar();
}

class _MyAppBar extends State<MyAppBar> {
  var _prefs = SharedPreferences.getInstance();
  Database _db = Database();
  String hadees = '';

  UserModel userdata = UserModel();
  ContentModel event = ContentModel();

  @override
  void initState() {
    getUserData();
    getHadees();
    getEvent();
    super.initState();
  }
  //function for playstore rating
  _launchURL() async {
  const url = 'https://play.google.com/store/apps';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              color: Color(0xFF645647),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QuickButton(),
                  Calender(),
                  Row(
                    children: [
                      DailyEvent(
                        text: 'Today\'s Event',
                        event: event,
                      ),
                      DailyEvent(
                        text: 'Today\'s Hadith',
                        hadees: hadees,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return FavoritePage(user: userdata);
                                },
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SettingScreen();
                                },
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.settings,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: Drawer(
          
          child: Material(
            color: Color(0xFF645647),
            child: ListView(
              children: [
const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(child: Text('Following The Prophet(SAW)',style:TextStyle(
          fontSize: 20,
        ))),
      ),

                const SizedBox(
                  height: 48,
                ),
                buildMenuItem(
                    text: 'Last Read',
                    icon: Icons.book,
                    onClicked: () => selectPage(context, 0)),
                const SizedBox(
                  height: 5,
                ),
                buildMenuItem(
                    text: 'Favorite',
                    icon: Icons.favorite,
                    onClicked: () => selectPage(context, 1)),
                const SizedBox(
                  height: 5,
                ),
                // buildMenuItem(
                //     text: 'Visit Our Website',
                //     icon: Icons.language,
                //     onClicked: () => selectPage(context, 2)),
                // const SizedBox(
                //   height: 5,
                // ),
                // buildMenuItem(
                //     text: 'Contact Us',
                //     icon: Icons.contact_mail,
                //     onClicked: () async {
                //       await _launchInBrowser("www.google.com");
                //     }),
                // const SizedBox(
                //   height: 5,
                // ),
                buildMenuItem(
                    text: 'Rate us',
                    icon: Icons.rate_review,
                    onClicked: () {
_launchURL();
                    }
                    ),

                const SizedBox(
                  height: 5,
                ),
                buildMenuItem(
                    text: 'Send data file',
                    icon: Icons.upload_file,
                    onClicked: () => selectPage(context, 7)),
                const SizedBox(
                  height: 5,
                ),
                buildMenuItem(
                    text: 'Request for Data',
                    icon: Icons.upload_file,
                    onClicked: () => selectPage(context, 8)),
                const SizedBox(
                  height: 5,
                ),
                // buildMenuItem(
                //   text: 'SignIn/Logout',
                //   icon: Icons.account_circle,
                //   onClicked: () => selectPage(context, 6),
                // ),
                const SizedBox(
                  height: 25,
                ),
                Divider(color: Colors.white70)
              ], //childreen
            ),
          ),
        ),
        appBar: AppBar(
            title: Center(
              child: Text(
                'FOLLOWING THE PROPHET',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFFD9727),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () async {
                  if (userdata.username == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UserInfoScreen(userdata);
                        },
                      ),
                    );
                  }
                },
              ),
            ]),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget buildMenuItem({
    final String text,
    final IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white60;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  selectPage(BuildContext context, int index) async {
    Navigator.of(context).pop(); //close the navigation bar
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LastReadPage(userdata),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavoritePage(
            user: userdata,
          ),
        ));
        break;
      // case 2:
      //   // Navigator.of(context).push(MaterialPageRoute(
      //   //   builder: (context) => VisitOurWebsitePage(),
      //   // ));
      //   break;
      // case 3:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => ContactUsPage(),
      //   ));
      //   break;
      // case 5:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => RateUsPage(),
      //   ));
      //   break;
      // case 6:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => LoginScreen(),
      //   ));
      //   break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SendData(),
        ));
        break;
        case 8:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RequestForData(),
        ));
        break;
      
    }
  }

  setCurrentDate() async {
    String finalDate = '';

    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    finalDate = formattedDate.toString();
    SharedPreferences prefs = await _prefs;
    prefs.setString('date', finalDate);
  }

  getEvent() async {
    await Firebase.initializeApp();
    SharedPreferences pref = await _prefs;
    var results = await _db.getTodayEvent(
      int.parse(DateTime.now().day.toString()),
      int.parse(
        DateTime.now().month.toString(),
      ),
    );
    if(results!=null){
      event = ContentModel(
        title: results['title'],
        subtitle: results['subtitle'],
        year: results['year'],
      );
    }
    if (event.title != '' || event.title != null) {
      pref.setString('todayEvent', event.title);
    } else {
      event=ContentModel(title: pref.getString('todayEvent'),) ;
    }
    setState(() {
      print('Event: ${event.title}');
    });
  }

  getHadees() async {
    SharedPreferences prefs = await _prefs;
    var id = prefs.getInt('hadeesId');
    String date = prefs.getString('date');
    if (date == null) {
      setCurrentDate();
    }
    if (id == null) {
      prefs.setInt('hadeesId', 1);
      id = 1;
      setCurrentDate();
    }
    String todayDate =
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
    if (todayDate.compareTo(date) != 0) {
      id += 1;
      setCurrentDate();
      prefs.setInt('hadeesId', id);
    }
    hadees = await _db.getHadees(19);

    setState(() {});
  }

  getUserData() async {
    SharedPreferences prefs = await _prefs;
    var username = prefs.getString('username');
    print("USerName $username");
    if (username != null) {
      var dbData = await _db.getUserData(username);
      print("DBDATA: " + dbData.toString());
      userdata = UserModel(
          username: dbData['username'],
          email: dbData['email'],
          lastRead: dbData['lastRead'],
          favorite: dbData['favorite']);
    }
  }
}
