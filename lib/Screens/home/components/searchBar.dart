import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/eventViewPage.dart';
import 'package:following_the_prophet/helper/database.dart';
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
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
            child: Text('Search'),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(20)),
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

  Database _db = Database();

  String data = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15),
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
                    icon: new Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search by title",
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EventViewScreen(
                                              data: snapshot.data.docs[index]
                                                  .data(),
                                              fromEvent: false,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (0.90),
                                        decoration: BoxDecoration(
                                            color: Colors.brown,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                          leading: Text((index+1).toString()),
                                          title: Text(snapshot.data.docs[index]
                                              .data()['title'],style: TextStyle(color: Colors.white ),),
                                        ),
                                      ),
                                    )
                                  : Container()
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EventViewScreen(
                                          data:
                                              snapshot.data.docs[index].data(),
                                          fromEvent: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        (0.90),
                                    decoration: BoxDecoration(
                                        color: Colors.brown,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ListTile(
                                      leading: Text((index+1).toString()),
                                      title: Text(snapshot.data.docs[index]
                                          .data()['title'],style: TextStyle(color: Colors.white )),
                                    ),
                                  ),
                                );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
