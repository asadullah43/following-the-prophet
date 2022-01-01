import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/eventViewPage.dart';
import 'package:following_the_prophet/Screens/home/components/quizPage.dart';
import 'package:following_the_prophet/helper/database.dart';
import 'package:following_the_prophet/models/contentModel.dart';
import 'package:following_the_prophet/quiz/quizmainpage.dart';
//import 'package:following_the_prophet/models/quizModel.dart';

class YearPage extends StatefulWidget {
  final int age;
  //final String age1;

  const YearPage({Key key, this.age,}) : super(key: key);

  @override
  State<YearPage> createState() => _YearPageState();
}

class _YearPageState extends State<YearPage> {
  List<ContentModel> yearData = [];
  //add this quizModel
 // List<QuizModel> quizYearData =[] ;
  //end
  Database _database = Database();
bool isLoading=true;
  // @override
  // void initState() {
  //   _getData();
  //   setState(() {});
  // }
   bool _isInit=true;
    void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    if (_isInit) {
    await  _getData();;
    
    }
    setState(() {
      isLoading= false;
    });
    _isInit = false;

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Year History',
            style: TextStyle(fontSize: 20, color: Color(0xFFFD9727)),
          ),
        ),
      ),
      body: isLoading?Center(child: CircularProgressIndicator()): yearData.length == 0
          ? Container(
              child: Center(
                child: Text("No data available at this moment"),
              ),
            )
          : Column(

              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [

                    Container(
                      height: 28,
                      width: 160,
                      child: Center(
                        child: Text("ProphetHood: ${widget.age - 40}"),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    Container(
                      height: 28,
                      width: 160,
                      child: Center(
                        child: Text("age: ${widget.age}"),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF9BBB94),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 28,
                      width: 160,
                      child: Center(
                        child: Text("Hijri: ${widget.age - 52}"),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFCDE300),
                      ),
                    ),
                    Container(
                      height: 28,
                      width: 160,
                      child: Center(
                        child: Text("Julian: ${widget.age + 569}"),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFFD9727),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //added take quiz button
              //till this
                Container(
                  height: MediaQuery.of(context).size.height * (0.68), //was 75//asad i reduce it from 0.69 to 0.50
                  child: yearData == null
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : /*child:*/ Container(
                        child: ListView.builder(
                            itemCount: yearData.length,
                            itemBuilder: (context, index) {
                              return Container(
                               
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EventViewScreen(
                                              data: yearData[index],
                                              fromEvent: false,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            (0.90),
                                        decoration: BoxDecoration(
                                            color: Colors.brown,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                          leading: Text("${index + 1}"),
                                          title: Text(yearData[index].title,style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              );
                            },
                            
                          ),
                      ),
                        
                        
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(

                      style: TextButton.styleFrom(textStyle: TextStyle(),
                      backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        print('take quiz pressed');
                        setState(
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => QuizMainPage(widget.age),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        " Attempt Quiz",
                        style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ), 
              ],
            ),
    );
  }

  _getData() async {
    var firebaseDocs = await _database.dataByYear(widget.age);
    firebaseDocs.forEach((element) {
      try {
        yearData.add(new ContentModel(
          title: element.data()['title'],
          subtitle: element.data()['subtitle'],
          year: element.data()['year'],
          details: element.data()['details'],
          youtubeLink: element.data()['youtubeLink'],
          image: element.data()['images'],
        ));
      } catch (e) {
        print(e);
      }
    });
    setState(() {});
  }
  //print(_database.dataByYear(widget.age));
  // quizyear 
 /* getQuizYear() async {
    var firebaseDocs = await _database.quizYear(widget.age1);
    firebaseDocs.forEach((element) {
      try {
        quizYearData.add(new QuizModel(
          quizYear: element.data()['quizYear'],
        
        ));
          print('tere mu ch chupa');
      } catch (e) {
        print(e.toString());
      }
    });
    setState(() {});
  }
  */
 
  
  //end here quizyear
}
