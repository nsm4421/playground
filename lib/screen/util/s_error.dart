import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ERROR",
          style: GoogleFonts.lobster(fontSize: 25),
        ),
      ),
      body: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
