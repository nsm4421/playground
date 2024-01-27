import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/data/data_source/remote/auth/auth.api.dart';
import 'package:my_app/dependency_injection.dart';

import '../../../core/constant/asset_path.dart';
import '../../../core/constant/enums/routes.enum.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const int _durationSecond = 2;

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: _durationSecond),
        // 로그인 여부에 따라 다른 곳으로 Routing
        () => context.go(getIt<AuthApi>().currentUser == null
            ? Routes.auth.path
            : Routes.main.path));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(child: SvgPicture.asset(AssetPath.appLogo)));
}
