import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constant/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
    return Center(
      child: Text("Karma App", style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
