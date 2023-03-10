import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  dataByYear(int year) async {
    var result = await FirebaseFirestore.instance
        .collection('content')
        .where('year', isEqualTo: year)
        .get()
        .catchError((e) {
      print(e);
    });
    return result.docs;
  }

  //adding for quiz year
  quizYear(String quizYear) async {
    var result = await FirebaseFirestore.instance
        .collection('Quiz')
        .where('quizYear', isEqualTo: quizYear)
        .get()
        .catchError((e) {
      print(e.toString());
    });
    return result.docs;
  }

  //end quiz year here
  checkFav(String title, String username) async {
    var result = await FirebaseFirestore.instance
        .collection('userContent')
        .where('username', isEqualTo: username)
        .get()
        .catchError((e) {
      print(e);
    });
    String docId = result.docs[0].id;
    List tempData = result.docs[0].data()['favorite'];
    if (tempData.contains(title)) {
      return true;
    } else
      return false;
  }

  getTodayEvent(int day, int month) async {
    var result = await FirebaseFirestore.instance
        .collection('content')
        .where('day', isEqualTo: day)
        .where('month', isEqualTo: month)
        .get()
        .catchError((e) {
      print(e);
    });
    if (result.docs[0].data() == null) {
      return null;
    } else
      return result.docs[0].data();
  }

  getHadees(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var resul = await FirebaseFirestore.instance.collection('Hadees').get();
    // var dateTime = DateTime.now();
    // try {
    //   if (prefs.getInt("today") != dateTime.day) {
    //     prefs.setInt("today", dateTime.day);
    //   }
    // } catch (e) {
    //   prefs.setInt("today", 0);

    // }
    if (resul.docs.length < id) {
      prefs.setInt('hadeesId', 1);

      var result = await FirebaseFirestore.instance
          .collection('Hadees')
          .where('id', isEqualTo: 1)
          .get()
          .catchError((e) {
        print(e);
      });
      return result.docs[0].data()['title'];
    } else {
      var result = await FirebaseFirestore.instance
          .collection('Hadees')
          .where('id', isEqualTo: id)
          .get()
          .catchError((e) {
        print(e);
      });
      return result.docs[0].data()['title'];
    }
  }

  addLastRead(String title, String username) async {
    var result = await FirebaseFirestore.instance
        .collection('userContent')
        .where('username', isEqualTo: username)
        .get()
        .catchError((e) {
      print(e);
    });
    String docId = result.docs[0].id;

    await FirebaseFirestore.instance.collection('userContent').doc(docId).set({
      'username': username,
      'lastRead': title,
      'email': result.docs[0].data()['email'],
      'favorite': result.docs[0].data()['favorite'],
    }).catchError((e) {
      print(e);
    });
    print('done');
  }

  addFav(String title, String username) async {
    var result = await FirebaseFirestore.instance
        .collection('userContent')
        .where('username', isEqualTo: username)
        .get()
        .catchError((e) {
      print(e);
    });
    String docId = result.docs[0].id;
    List tempData = result.docs[0].data()['favorite'];

    if (!tempData.contains(title)) {
      if (tempData[0] == '') {
        tempData[0] = title;
      } else {
        tempData.add(title);
      }
      FirebaseFirestore.instance.collection('userContent').doc(docId).set({
        'username': username,
        'favorite': tempData,
        'email': result.docs[0].data()['email'],
        'lastRead': result.docs[0].data()['lastRead'],
      });
      return true;
    } else {
      tempData.remove(title);
      if (tempData.length == 0) {
        tempData.add('');
      }
      FirebaseFirestore.instance.collection('userContent').doc(docId).set({
        'username': username,
        'favorite': tempData,
        'email': result.docs[0].data()['email'],
        'lastRead': result.docs[0].data()['lastRead'],
      });
      return false;
    }
  }

  dataBySubtitle(String events) async {
    var result = await FirebaseFirestore.instance
        .collection('content')
        .where('subtitle', isEqualTo: events)
        .get()
        .catchError((e) {
      print(e);
    });

    return result.docs;
  }

  dataByTitle(String events) async {
    var result = await FirebaseFirestore.instance
        .collection('content')
        .where('title', isEqualTo: events)
        .get()
        .catchError((e) {
      print(e);
    });
    return result.docs;
  }

  getUsername(String email) async {
    var result = await FirebaseFirestore.instance
        .collection('userContent')
        .where('email', isEqualTo: email)
        .get()
        .catchError((e) {
      print(e);
    });
    var username = result.docs[0].data()['username'];
    return username;
  }

  uploadUserInfo(userMap) async {
    await FirebaseFirestore.instance
        .collection('userContent')
        .add(userMap)
        .catchError((e) {
      print("Error $e");
    });
  }

  getUserData(String username) async {
    var result = await FirebaseFirestore.instance
        .collection('userContent')
        .where('username', isEqualTo: username)
        .get()
        .catchError((e) {
      print(e);
    });

    return result.docs[0].data();
  }
}
