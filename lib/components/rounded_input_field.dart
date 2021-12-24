import 'package:flutter/material.dart';

import 'package:following_the_prophet/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.controller,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        
        onChanged: onChanged,
        controller: controller,
        cursorColor: Color(0xFF080603),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xFF080603),
          ),
          hintText: hintText,
          border: InputBorder.none,
          
        ),
      ),
    );
  }
}
