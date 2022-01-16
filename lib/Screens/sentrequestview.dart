import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class viewrequest extends StatefulWidget {
  final comp;
  static final routeName = 'viewrequest';

  viewrequest(this.comp);

  @override
  _ViewdataviewState createState() => _ViewdataviewState();
}

class _ViewdataviewState extends State<viewrequest> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(6),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text(
              'Topic: ${widget.comp.data()['Topic']}',
              softWrap: true,
              style: TextStyle(
                color: Colors.green[400],
              ),
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.details_outlined),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return editEmail(
                                context, widget.comp.data(), widget.comp.id);
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Container(
          //         child: FittedBox(
          //           fit: BoxFit.contain,
          //           child: Text(
          //             'Topic:${widget.comp.data()['Topic']}',
          //             softWrap: true,
          //             style: TextStyle(
          //               color: Colors.grey,
          //             ),
          //           ),
          //         ),
          //       ),
        ],
      ),
    );
  }
}

Widget editEmail(BuildContext context, data, id) {
  return SingleChildScrollView(
    child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Detail'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Status: ${data['status'] == "pending" ? "data not uploaded" : "Data uploaded"}',
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Description:' + (data['Description']),
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Topic:' + (data['Topic'].toString()),
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Requested Data:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )),
                  ),
                  data['status'] != "pending"
                      ? data['Main'] == "Content"
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'details:' + (data['details'].toString()),
                                      softWrap: true,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'titile:' + (data['title'].toString()),
                                      softWrap: true,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'subtitle:' +
                                          (data['subtitle'].toString()),
                                      softWrap: true,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'youtubeLink:' +
                                          (data['youtubeLink'].toString()),
                                      softWrap: true,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Date :${data['day'].toString()}-${data['month'].toString()}-${data['year'].toString()}',
                                      softWrap: true,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      )),
                                ),
                              ],
                            )
                          : data['Main'] == "Hadees" ||
                                  data['Main'] == "A-Hadees"
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'Hadees:' +
                                              (data['title'].toString()),
                                          softWrap: true,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          )),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'Description from Admin:' +
                                              (data['Completedetail']
                                                  .toString()),
                                          softWrap: true,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          )),
                                    ),
                                  ],
                                )
                      : Text(
                          "Uploaded data will be show here and on content page",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          )),
                ]))),
  );
}
