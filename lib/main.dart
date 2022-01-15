import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'appbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.red,
        primaryColor: Color(0xFF645647),

        scaffoldBackgroundColor:
            //Color(0xFF787777),
            Color(0xFF645647),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: MyAppBar(),
    );
  }
}
