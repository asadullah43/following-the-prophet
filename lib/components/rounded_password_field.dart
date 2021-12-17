import 'package:flutter/material.dart';
import 'package:following_the_prophet/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        controller: controller,
        onChanged: onChanged,
        cursorColor: Color(0xFF080603),
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Color(0xFF080603),
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Color(0xFF080603),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
