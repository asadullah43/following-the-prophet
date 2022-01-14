import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/eventViewPage.dart';
import 'package:following_the_prophet/models/contentModel.dart';

class DailyEvent extends StatefulWidget {
  DailyEvent({this.text, this.hadees, this.event});
  final String text;
  String hadees;
  ContentModel event;

  @override
  State<DailyEvent> createState() => _DailyEventState();
}

class _DailyEventState extends State<DailyEvent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (widget.hadees == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventViewScreen(
                  data: widget.event,
                  fromEvent: true,
                ),
              ),
            );
          } else {
            //Container(child: Text('data'),);
            showAlertDialog(context);
          }
        },
        child: Container(
          child: (widget.text.compareTo('Today\'s Hadith') == 0)
              ? Column(
                  children: [
                    Text(widget.text),
                    widget.hadees == null
                        ? Text('')
                        : Text(widget.hadees, overflow: TextOverflow.ellipsis)
                  ],
                )
              : Column(
// <<<<<<< HEAD
//             children: [
//               Text(widget.text),
//               widget.event == null || widget.event.title == null
//                   ? Center(child: Text('No Event occured on today date'))
//                   : Center(child: Text(widget.event.title)),
//               widget.event == null || widget.event.title == null
//                   ? Text('')
//                   : Text(widget.event.year.toString()),
//             ],
//           ),
// =======
                  children: [
                    Text(widget.text),
                    widget.event == null || widget.event.title == null
                        ? Text(
                            'No Event occured on today date',
                            textAlign: TextAlign.center,
                          )
                        : Text(widget.event.title),

                    // widget.event == null || widget.event.title == null
                    //     ? Text('')
                    //     : Text(widget.event.year.toString()),
                  ],
                ),
//>>>>>>> cb59be5995f04f45ba613ee95d9b8947e855d54b
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green[700],
            ),
            color: Colors.green[200],
          ),
          height: 80,
          width: 200,
        ),
      ),
    );
  }
  /*Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
            showAlertDialog(context);
        },
        child: Container(

          child: (widget.text.compareTo('Today\'s Hadith',) == 0)
              ? Column(

                  children: [
                    Text(widget.text,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,fontSize: 20,

                    ),),
                    widget.hadees == null ? Text('',) : Text(widget.hadees),
                  ],
                )
              : Column(
                  children: [
                    Text(widget.text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,fontSize: 20,
                    ),),
                    widget.event == null || widget.event.title == null
                        ? Text('No Event occured on today date')
                        : Text(widget.event.title,),
                    widget.event == null || widget.event.title == null
                        ? Text('')
                        : Text(widget.event.year.toString()),
                  ],
                ),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Color(0xFF9BBB94),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 140,
          width: 200,
        ),
      ),
    );
  }*/

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text(
          "Hadees",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Text(widget.hadees == null ? '' : widget.hadees),
      backgroundColor: Colors.teal,
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
