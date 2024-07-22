import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import '../../../core/route/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const int _duration = 2;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: _duration), () {
      FlutterNativeSplash.remove();
      context.go(RoutePaths.main.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loadings...",
            style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
