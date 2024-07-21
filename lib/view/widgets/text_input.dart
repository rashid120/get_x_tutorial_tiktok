import 'package:flutter/material.dart';
import 'package:get_x_tutorial/constants.dart';

class TextInputField extends StatelessWidget {

  final TextEditingController controller;
  final IconData myIcon;
  final String myLabelText;
  final bool toHide;

  const TextInputField({super.key, required this.controller, required this.myIcon, required this.myLabelText, this.toHide = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(myIcon),
        labelText: myLabelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor
          )
        ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  color: borderColor
              )
          ),

      ),
      obscureText: toHide,
    );
  }
}
