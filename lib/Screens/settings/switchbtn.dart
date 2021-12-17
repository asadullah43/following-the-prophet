import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

class SwitchButton extends StatefulWidget {
  final String text;

  const SwitchButton({Key key, this.text}) : super(key: key);
  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  SharedPreferences prefs;

  bool status = false;
  @override
  void initState() {
    getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlutterSwitch(
            width: 80.0,
            height: 30.0,
            valueFontSize: 10.0,
            toggleSize: 20.0,
            value: status,
            borderRadius: 30.0,
            padding: 8.0,
            showOnOff: true,
            onToggle: (val) {
              setState(() {
                status = val;
                setState(() {});
                if (status) {
                  setState(() {
                    if (widget.text == 'Screen') {
                      Wakelock.enable();
                    }
                    prefs.setBool(widget.text, true);
                  });
                } else {
                  setState(() {
                    if (widget.text == 'Screen') {
                      Wakelock.disable();
                    }
                    prefs.setBool(widget.text, false);
                  });
                }
              });
            }));
  }

  getState() async {
    prefs = await SharedPreferences.getInstance();
    var tempstatus = prefs.getBool(widget.text);
    if (tempstatus == null) {
      prefs.setBool(widget.text, false);
    } else {
      status = tempstatus;
    }
    setState(() {});
  }
}
