import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constant/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _duration = 2;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: _duration), () {
      context.pushReplacement(Routes.entry.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO : splash screen 디지인
    return Center(
      child:
          Text("SPLASH PAGE", style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
