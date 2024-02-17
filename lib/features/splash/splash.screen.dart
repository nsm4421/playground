import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/constant/route.constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int _duration = 2;

  @override
  void initState() {
    Timer(Duration(seconds: _duration), () {
      context.pushReplacement(Routes.welcome.path);
    });
    super.initState();
  }

  // TODO : Splash 페이지 디자인
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Splash Screen"),
        ),
        body: Column(
          children: [Text("Splash Screen")],
        ),
      );
}
