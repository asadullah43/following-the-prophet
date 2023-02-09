import 'package:flutter/material.dart';

import 'package:following_the_prophet/models/contentModel.dart';

// ignore: must_be_immutable
class QuizPage extends StatelessWidget {
  int age;

  QuizPage({this.age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Quiz Page',
            style: TextStyle(fontSize: 20, color: Color(0xFFFD9727)),
          ),
        ),
      ),
      body: QuizPageFul(),
    );
  }
}

class QuizPageFul extends StatefulWidget {
  // const QuizPageFul({ Key? key }) : super(key: key);

  @override
  _QuizPageFulState createState() => _QuizPageFulState();
}

class _QuizPageFulState extends State<QuizPageFul> {
  List<ContentModel> yearData = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  List<Icon> scoorKeeper = [];
  List<String> questions = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[0],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.green,
              ),
              // textColor: Colors.white,
              //color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                setState(() {
                  questions[0] = questions[1];
                  scoorKeeper.add(
                    const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  );
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  scoorKeeper.add(
                    const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  );
                });
              },
            ),
          ),
        ),
        Row(
          children: scoorKeeper,
        )
      ],
    );
  }
}
