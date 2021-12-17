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
      margin: EdgeInsets.only(top: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * (65),
        height: 40.0,
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

            padding: EdgeInsets.all(5),
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),

            child: Text('Search'),

            decoration: BoxDecoration(

              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(20)
            ),
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
  Database _db = Database();

  ContentModel data;

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
                  onSubmitted: (value) {
                    getDataAndRoute(value);
                  },
                  decoration: new InputDecoration(
                    icon: new Icon(Icons.search,color: Colors.white,),
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
            (data == null || data.title == '' || data.title == null)
                ? Container(
                    child: Center(
                      child: Text("Not found"),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventViewScreen(
                            data: data,
                            fromEvent: false,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * (0.90),
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: Text("1"),
                        title: Text(data.title),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  getDataAndRoute(String event) async {
    var docs = await _db.dataByTitle(event);
    data = ContentModel(
      title: docs[0].data()['title'],
      subtitle: docs[0].data()['subtitle'],
      year: docs[0].data()['year'],
      details: docs[0].data()['details'],
      youtubeLink: docs[0].data()['youtubeLink'],
      image: docs[0].data()['images'],
    );
    setState(() {
      print(data);
    });
  }
}
