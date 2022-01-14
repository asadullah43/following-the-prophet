import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/home/components/quickButtonLayout.dart';

class QuickButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        color: Colors.green[50],
      ),
      height: 80,
      width: 400,
      child: Row(
        children: [
          ButtonLayout(text: 'WARS'),
          ButtonLayout(text: 'HIJRAT'),
          ButtonLayout(text: 'MADANI\nLIFE'),
          ButtonLayout(text: 'MAKKI\nLIFE'),
        ],
      ),
    );
  }
}
