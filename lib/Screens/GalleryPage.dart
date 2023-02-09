import 'package:flutter/material.dart';
import 'package:following_the_prophet/helper/database.dart';

// ignore: must_be_immutable
class GalleryPage extends StatefulWidget {
  String title;

  GalleryPage(this.title);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List images = [];
  Database _db = Database();
  bool isLoading = true;

  @override
  void initState() {
    getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GalleryPage'),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : images.length == 0
              ? Container(
                  child: Center(
                    child: Text("NO Images"),
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(10),
                  child: GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    crossAxisCount: 2,
                    children: List.generate(images.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(images[index]),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
    );
  }

  getImages() async {
    var data = await _db.dataByTitle(widget.title);
    images = data[0].data()['image'];
    setState(() {
      isLoading = !isLoading;
    });
  }
}
