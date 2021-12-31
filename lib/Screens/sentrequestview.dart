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
            leading: FittedBox(
              child: Text(
                'Description: ${widget.comp.data()['Description']}',
                style: TextStyle(
                  color: Colors.green,
                ),
                softWrap: true,
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Topic:${widget.comp.data()['Topic']}',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget editEmail(BuildContext context, data, id) {
  return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                                child:
                                    Text('titile:' + (data['title'].toString()),
                                        softWrap: true,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'subtitle:' + (data['subtitle'].toString()),
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
                        : data['Main'] == "Hadees" || data['Main'] == "A-Hadees"
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Hadees:' + (data['title'].toString()),
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
                                            (data['Completedetail'].toString()),
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
              ])));
}
// Padding(
//     padding: const EdgeInsets.only(bottom: 8.0),
//     child: ElevatedButton(
//       style: ButtonStyle(
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         )),
//         padding: MaterialStateProperty.all(EdgeInsets.symmetric(
//                 vertical: 25,
//                 horizontal: MediaQuery.of(context).size.width -
//                     MediaQuery.of(context).padding.top) *
//             0.35),
//         backgroundColor: MaterialStateProperty.all(
//             Color(0xff8d43d6)), // <-- Button color
//         overlayColor:
//             MaterialStateProperty.resolveWith<Color?>((states) {
//           if (states.contains(MaterialState.pressed))
//             return Color(0xffB788E5); // <-- Splash color
//         }),
//       ),
//       child: FittedBox(
//         child: const Text(
//           "Mark as Done",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       onPressed: () {
//         Navigator.of(context).pushNamed(Feedbacks.routename,
//             arguments: {"status": "Complete", "id": id});
//       },
//     )),
// Padding(
//     padding: const EdgeInsets.only(bottom: 8.0),
//     child: ElevatedButton(
//       style: ButtonStyle(
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         )),
//         padding: MaterialStateProperty.all(EdgeInsets.symmetric(
//                 vertical: 25,
//                 horizontal: MediaQuery.of(context).size.width -
//                     MediaQuery.of(context).padding.top) *
//             0.35),
//         backgroundColor: MaterialStateProperty.all(
//             Color(0xff8d43d6)), // <-- Button color
//         overlayColor:
//             MaterialStateProperty.resolveWith<Color?>((states) {
//           if (states.contains(MaterialState.pressed))
//             return Color(0xffB788E5); // <-- Splash color
//         }),
//       ),
//       child: FittedBox(
//         child: const Text(
//           "ReAssign Again",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       onPressed: () async {
//         Navigator.of(context).pushNamed(Feedbacks.routename,
//             arguments: {"status": "Working", "id": id});
// await FirebaseFirestore.instance
//     .collection("Duties")
//     .doc(id)
//     .update({
//   "status": "Working",
//   "Updation":
//       "Report is not correct as duty assign Please attach the correct report again"
// });
// await FirebaseFirestore.instance
//     .collection("DutyReport")
//     .doc(id)
//     .delete();
// Navigator.of(context)
//     .pushNamed(PoliceDutiesStatus.routeName);
// return await showDialog(
//   context: context,
//   builder: (ctx) => AlertDialog(
//     title: Text('Update'),
//     content: Text("Status Update"),
//     actions: <Widget>[
//       TextButton(
//         child: Text('Ok'),
//         onPressed: () {
//           Navigator.of(ctx).pop(false);
//         },
//       ),
//     ],
//   ),
// );
