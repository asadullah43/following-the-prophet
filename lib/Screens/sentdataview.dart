import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Viewdataview extends StatefulWidget {
  final comp;
  static final routeName = 'Viewdataview';

  Viewdataview(this.comp);

  @override
  _ViewdataviewState createState() => _ViewdataviewState();
}

class _ViewdataviewState extends State<Viewdataview> {
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
                'Day: ${widget.comp.data()['day']}',
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
                      'title:${widget.comp.data()['title']}',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'subtitle:${widget.comp.data()["subtitle"]}',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget editEmail(BuildContext context, data, id) {
  void launchURL(link) async {
    var url = link;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                      'Status: ${data['status'] == "pending" ? "Not Approved yet" : "Approved and added"}',
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Month:' + (data['month'].toString()),
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Year:' + (data['year'].toString()),
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('youtubeLink:' + (data['youtubeLink']),
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      )),
                ),
                IconButton(
                  color: Colors.grey,
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    launchURL(data['youtubeLink']);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('details:' + (data['details']),
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('title:' + (data['title']),
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      )),
                ),
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
