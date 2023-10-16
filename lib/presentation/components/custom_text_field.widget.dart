import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextInputType textInputType;
  final double width;
  final double height;
  final TextEditingController? tec;
  final IconData? prefixIconData;
  final String labelText;
  final bool isObscure;
  final double fontSize;
  final int? maxLength;
  final int? maxLine;
  final String? helperText;
  final String? errorText;
  final String? hintText;

  const CustomTextFieldWidget(
      {super.key,
      this.textInputType = TextInputType.text,
      this.width = double.infinity,
      this.height = 70,
      this.tec,
      this.prefixIconData,
      this.labelText = "",
      this.isObscure = false,
      this.fontSize = 23,
      this.maxLength,
      this.maxLine = 1,
      this.helperText,
      this.errorText,
      this.hintText});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: TextField(
          keyboardType: textInputType,
          style: TextStyle(fontSize: fontSize),
          controller: tec,
          obscureText: isObscure,
          maxLength: maxLength,
          maxLines: maxLine,
          decoration: InputDecoration(
              hintText: hintText,
              helperText: helperText,
              errorText: errorText,
              labelText: labelText,
              prefixIcon: prefixIconData != null
                  ? Icon(prefixIconData)
                  : const Padding(padding: EdgeInsets.all(0)),
              hintStyle: TextStyle(fontSize: fontSize - 5),
              labelStyle: TextStyle(fontSize: fontSize - 5),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey))),
        ),
      );
}
