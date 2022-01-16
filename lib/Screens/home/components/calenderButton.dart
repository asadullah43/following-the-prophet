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
      padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 28,
                    width: 34,
                    child: Center(
                      child: Text(prophetHood,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 28,
                    width: 34,
                    child: Center(
                      child: Text(age,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF9BBB94),
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
                    width: 34,
                    child: Center(
                      child: Text(hijri,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFCDE300),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 28,
                    width: 34,
                    child: Center(
                      child: Text(
                        juilan,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFD9727),
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
