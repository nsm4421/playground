import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prj/screen/custom_design/theme.dart';

import '../custom_design/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Function(String text) onChanged;
  final double height;
  final TextInputAction textInputAction;

  const CustomTextField(
      {Key key,
      this.hint,
      this.onChanged,
      this.height = 54.0,
      this.textInputAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: isLightTheme(context) ? Colors.white : kBubbleDark,
          borderRadius: BorderRadius.circular(35.0),
          border: Border.all(
              color: isLightTheme(context)
                  ? const Color(0xFFC4C4C4)
                  : const Color(
                      0xFF393737,
                    ),
              width: 1.5)),
      child: TextField(
          keyboardType: TextInputType.text,
          onChanged: onChanged,
          textInputAction: textInputAction,
          cursorColor: kPrimary,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              hintText: hint,
              border: InputBorder.none)),
    );
  }
}
