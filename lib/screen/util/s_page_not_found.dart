import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context, false);
            },
          ),
          title: Text(
            "잘못된 접근",
            style: GoogleFonts.lobster(fontSize: 25),
          ),
        ),
        body: const Center(
          child: Text(
            "존재하지 않는 페이지 입니다...",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
