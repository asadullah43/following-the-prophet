import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/eventViewPage.dart';

import 'package:following_the_prophet/models/contentModel.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * (65),
        height: 50.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SearchScreen();
                },
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.only(top: 8, left: 6),
            margin: EdgeInsets.fromLTRB(24, 5, 24, 5),
            child: Text(
              'Search',
              style: TextStyle(fontSize: 16),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(2)),
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var streams = FirebaseFirestore.instance.collection('content').snapshots();

  String data = "";
  ContentModel model;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF645647),
          title: Text(
            "Search",
            style: TextStyle(
              color: Color(0xFFFD9727),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
              //margin: EdgeInsets.only(top: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * (65),
                height: 50.0,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      data = value;
                    });
                  },
                  // onSubmitted: (value) {
                  // //  getDataAndRoute(value);
                  // },
                  decoration: new InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: "Search by title",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: streams,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null)
                      return Center(child: CircularProgressIndicator());
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return data != ""
                              ? (snapshot.data.docs[index].data()
                                          as Map)["title"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(data.toString().toLowerCase())
                                  ? GestureDetector(
                                      onTap: () {
                                        model = ContentModel(
                                          title: snapshot.data.docs[index]
                                              .data()['title'],
                                          subtitle: snapshot.data.docs[index]
                                              .data()['subtitle'],
                                          year: snapshot.data.docs[index]
                                              .data()['year'],
                                          details: snapshot.data.docs[index]
                                              .data()['details'],
                                          youtubeLink: snapshot.data.docs[index]
                                              .data()['youtubeLink'],
                                          image: snapshot.data.docs[index]
                                              .data()['images'],
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EventViewScreen(
                                              data: model,
                                              fromEvent: false,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (0.90),
                                        decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                          leading: Text(
                                            (index + 1).toString(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          title: Text(
                                            snapshot.data.docs[index]
                                                .data()['title'],
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                              : GestureDetector(
                                  onTap: () {
                                    model = ContentModel(
                                      title: snapshot.data.docs[index]
                                          .data()['title'],
                                      subtitle: snapshot.data.docs[index]
                                          .data()['subtitle'],
                                      year: snapshot.data.docs[index]
                                          .data()['year'],
                                      details: snapshot.data.docs[index]
                                          .data()['details'],
                                      youtubeLink: snapshot.data.docs[index]
                                          .data()['youtubeLink'],
                                      image: snapshot.data.docs[index]
                                          .data()['images'],
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EventViewScreen(
                                          data: model,
                                          fromEvent: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    width: MediaQuery.of(context).size.width *
                                        (0.90),
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      leading: Text(
                                        (index + 1).toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      title: Text(
                                        snapshot.data.docs[index]
                                            .data()['title'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                );
                          // SizedBox(height: 10,),
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
