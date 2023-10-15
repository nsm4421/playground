import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const int _splashDuration = 2;

  // 2초 뒤, 홈화면으로 이동
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: _splashDuration),
      () => Get.offAllNamed("/login"),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO : 디자인 수정
    return const Scaffold(
      body: Center(
        child: Text(
          "Hello",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
