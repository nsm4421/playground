import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController? tec;
  final IconData? prefixIconData;
  final String labelText;
  final bool isObscure;
  final double fontSize;
  final int? maxLength;
  final int? maxLine;

  const CustomTextFieldWidget({
    super.key,
    this.width = double.infinity,
    this.height = 70,
    this.tec,
    this.prefixIconData,
    this.labelText = "",
    this.isObscure = false,
    this.fontSize = 18,
    this.maxLength,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: TextField(
          controller: tec,
          obscureText: isObscure,
          maxLength: maxLength,
          maxLines: maxLine,
          decoration: InputDecoration(
              labelText: labelText,
              // 아이콘이 있는 경우 적용
              prefixIcon: prefixIconData != null
                  ? Icon(prefixIconData)
                  : const Padding(padding: EdgeInsets.all(0)),
              labelStyle: TextStyle(fontSize: fontSize),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey))),
        ),
      );
}
