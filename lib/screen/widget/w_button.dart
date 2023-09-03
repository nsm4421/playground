import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.label,
    required this.callback,
    this.width,
    this.fontSize,
    this.textColor,
    this.bgColor,
  });

  final String label;
  final VoidCallback callback;
  final double? width;
  final double? fontSize;
  final Color? textColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.all(4),
        alignment: Alignment.center,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor ?? Colors.teal,
        ),
        child: Text(
          label,
          style: GoogleFonts.karla(
            fontSize: fontSize ?? 28,
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
