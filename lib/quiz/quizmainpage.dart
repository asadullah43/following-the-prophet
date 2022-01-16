//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:following_the_prophet/models/quizModel.dart';
import 'package:following_the_prophet/quiz/quiz_score.dart';
//import 'package:following_the_prophet/widget/quiz_widget.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import '../helper/database.dart';

class QuizMainPage extends StatefulWidget {
  final int age;
  QuizMainPage(this.age);
  @override
  State<QuizMainPage> createState() => _QuizMainPageState();
}

class _QuizMainPageState extends State<QuizMainPage> {
  List<QuizModel> quizData = [];
  List<Icon> scoorKeeper = [];
  Database _database = Database();
  bool isLoading = true;
  // @override
  // void initState() {
  //   getQuizData();
  //   //setState(() {});
  //   super.initState();
  // }
  bool _isInit = true;
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    if (_isInit) {
      await getQuizData();
    }
    setState(() {
      isLoading = false;
    });
    _isInit = false;

    super.didChangeDependencies();
  }

  String selectedOption = "";
  String correctedOption = "";
  int indexNum = 0;
  int correct = 0;
  int check = 0;
  int total = 0;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    isLoading == false && quizData.length != 0
        ? correctedOption = quizData[indexNum].correctAnswer
        : 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF645647),
        title: Text(
          "Quiz Of Year ${widget.age}",
          style: TextStyle(
              fontSize: 20,
              color: Color(0xFFFD9727),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : quizData.length == 0
              ? Container(
                  child: Center(
                    child: Text("No Quiz"),
                  ),
                )
              : Container(
                  child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Q${indexNum + 1}: ${quizData[indexNum].questionText}",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = quizData[indexNum].option1;
                            });
                          },
                          child: Container(
                            child: Text(quizData[indexNum].option1,
                                style:
                                    selectedOption == quizData[indexNum].option1
                                        ? TextStyle(
                                            fontSize: 20,
                                            backgroundColor: Colors.blue,
                                            color: Colors.white)
                                        : TextStyle(
                                            fontSize: 20,
                                            backgroundColor: Colors.white,
                                            color: Colors.black)),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = quizData[indexNum].option2;
                          });
                        },
                        child: Text(
                          quizData[indexNum].option2,
                          style: selectedOption == quizData[indexNum].option2
                              ? TextStyle(
                                  fontSize: 20,
                                  backgroundColor: Colors.blue,
                                  color: Colors.white)
                              : TextStyle(
                                  fontSize: 20,
                                  backgroundColor: Colors.white,
                                  color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = quizData[indexNum].option3;
                          });
                        },
                        child: Text(
                          quizData[indexNum].option3,
                          style: selectedOption == quizData[indexNum].option3
                              ? TextStyle(
                                  fontSize: 20,
                                  backgroundColor: Colors.blue,
                                  color: Colors.white)
                              : TextStyle(
                                  fontSize: 20,
                                  backgroundColor: Colors.white,
                                  color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = quizData[indexNum].option4;
                          });
                        },
                        child: Text(
                          quizData[indexNum].option4,
                          style: selectedOption == quizData[indexNum].option4
                              ? TextStyle(
                                  fontSize: 20,
                                  backgroundColor: Colors.blue,
                                  color: Colors.white)
                              : TextStyle(
                                  fontSize: 20,
                                  backgroundColor: Colors.white,
                                  color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (selectedOption == correctedOption) {
                              scoorKeeper.add(
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              );
                              correct = correct + 1;
                              total++;
                              print("total is ");
                              print(total);
                            } else {
                              scoorKeeper.add(
                                const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              );
                              correct = correct;
                              total++;
                              print("total of incorrect");
                              print(total);
                            }
                            if (indexNum == quizData.length - 1) {
                              //Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizScore(
                                      correct: correct,
                                      total: total,
                                    ),
                                  ));
                            } else {
                              indexNum++;
                            }
                          });
                        },
                        child: Text(
                          indexNum == quizData.length - 1
                              ? "Submit"
                              : "Next Question",
                          //: "Submit",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFFFD9727),
                          ),
                        ),
                      ),
                      Row(
                        children: scoorKeeper,
                      ),
                    ],
                  ),
                )),
    );
  }

  getQuizData() async {
    var firebaseDocs = await _database.quizYear(widget.age.toString());
    firebaseDocs.forEach((element) {
      try {
        quizData.add(new QuizModel(
          quizYear: element.data()['quizYear'],
          questionText: element.data()['questionText'],
          option1: element.data()['option1'],
          option2: element.data()['option2'],
          option3: element.data()['option3'],
          option4: element.data()['option4'],
          correctAnswer: element.data()['correctAnswer'],
        ));
      } catch (e) {
        print(e);
      }
    });
    setState(() {});
  }
}
