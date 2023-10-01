import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/theme/constant/icon_paths.dart';
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
    Timer(Duration(seconds: duration), () => context.go(RoutePath.main.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset(IconPaths.splashImage)),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
