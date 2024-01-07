import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const int _durationSec = 2;

  @override
  void initState() {
    super.initState();
    // after 2 sec, go to main page
    Future.delayed(const Duration(seconds: _durationSec), () {
      context.go('/main');
    });
  }

  // TODO : UI Design
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('SPLASH PAGE'),
        ),
      );
}
