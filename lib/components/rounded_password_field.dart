import 'package:flutter/material.dart';
import 'package:following_the_prophet/components/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.controller,
  }) : super(key: key);
  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}
class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
 bool _showPassword = true;

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _showPassword,
        controller: widget.controller,
        onChanged: widget.onChanged,
        cursorColor: Color(0xFF080603),
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(

            Icons.lock,
            color: Color(0xFF080603),
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              _togglevisibility();
            },
            child: _showPassword ? Icon(
              Icons.visibility_off,
              color: Color(0xFF080603),
            )
            :Icon(
              Icons.visibility,
              color: Color(0xFF080603),
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
