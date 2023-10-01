import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../routes/route_path.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const int duration = 2;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: duration), () => context.go(RoutePath.home.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset('assets/svg/splash_image.svg')),
      backgroundColor: Color(0xFF497388),
    );
  }
}
