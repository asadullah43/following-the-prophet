import 'package:flutter/material.dart';
import 'package:following_the_prophet/Screens/settings/dropdownbtn.dart';
import 'package:following_the_prophet/Screens/settings/switchbtn.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 20, color: Color(0xFFFD9727)),
          ),
        ),
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // buildSettingItem(
          //   text: 'Language',
          //   icon: Icons.language,
          //   postWidget: DropDownBtn(),
          //   width: MediaQuery.of(context).size.width - 50,
          // ),
          SizedBox(
            height: 15,
          ),
          buildSettingItem(
            text: 'Change Mode',
            icon: Icons.brightness_4,


            postWidget: SwitchButton(
              text: 'Mode',
            ),
            width: MediaQuery.of(context).size.width - 50,
          ),
          SizedBox(
            height: 5,
          ),
          buildSettingItem(
            text: 'Font Size',
            icon: Icons.format_indent_decrease,
            postWidget: DropDownBtn(),
            width: MediaQuery.of(context).size.width - 50,
          ),
          SizedBox(
            height: 5,
          ),
          buildSettingItem(
            text: 'Keep Screen On',
            icon: Icons.computer,

            postWidget: SwitchButton(
              text: "Screen",
            ),
            width: MediaQuery.of(context).size.width - 50,
          ),
          SizedBox(
            height: 5,
          ),
        ],
      )),
    );
  }
}

Widget buildSettingItem({
  String text,
  IconData icon,

  Widget postWidget,
  double width,
}) {
  final color = Colors.white;
  final hoverColor = Colors.white60;
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Container(
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color: color),
          ),
          SizedBox(
            width: 30,
          ),
          postWidget != null
              ? postWidget
              : Container(
                  width: 0.1,
                  height: 0.1,
                ),
        ],
      ),
    ),
    hoverColor: hoverColor,
  );
}
