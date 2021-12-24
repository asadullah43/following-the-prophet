
import 'package:flutter/material.dart';

class RequestForData extends StatelessWidget {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _discription = new TextEditingController();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('RequestForData'),
         // backgroundColor: Colors.green,
        ),
        body: isloading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Topic",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              controller: _titleController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Container(
                      child: Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextFormField(
                        maxLines: 5,
                        minLines: 5,
                        decoration: InputDecoration(
                          hintText: "Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _discription,
                      ),
                    ),
                  ]),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 16, 50, 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      textStyle: TextStyle(),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Send Request",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]));
  }
}