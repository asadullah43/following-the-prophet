import 'package:flutter/material.dart';

class YearWise extends StatelessWidget {
  YearWise({this.prophetHood, this.age, this.hijri, this.juilan});
  final String prophetHood;
  final String age;
  final String hijri;
  final String juilan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 28,
                    width: 30,
                    child: Center(
                      child: Text(prophetHood),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan[200],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 28,
                    width: 30,
                    child: Center(
                      child: Text(age),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal[100],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 28,
                    width: 30,
                    child: Center(
                      child: Text(hijri),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 28,
                    width: 30,
                    child: Center(
                      child: Text(juilan),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
