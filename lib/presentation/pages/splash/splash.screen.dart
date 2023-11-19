import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/asset_path.dart';
import '../../../core/constant/enums/routes.enum.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const int _durationSecond = 2;

  // TODO : 로그인 여부에 따라 routing 경로 다르게 적용하기
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: _durationSecond),
        () => context.go(Routes.signIn.path));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(child: SvgPicture.asset(AssetPath.appLogo)));
}
