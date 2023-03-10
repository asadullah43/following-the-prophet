import 'package:flutter/material.dart';
import 'package:following_the_prophet/models/quizModel.dart';

class QuizScore extends StatefulWidget {
  final int age;
  final int correct, total;
  QuizScore({this.age, @required this.correct, @required this.total});
  @override
  State<QuizScore> createState() => _QuizScoreState();
}

class _QuizScoreState extends State<QuizScore> {
  List<QuizModel> quizData = [];
  //final int correct,total;
  //final int age;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF645647),
        title: Text(
          "Result",
          style: TextStyle(
              fontSize: 20,
              color: Color(0xFFFD9727),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Center(
          child: Text(
            " Score: ${widget.correct} \n Total:  "
            "${widget.total}\n Wrong:  ${widget.total - widget.correct}",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
