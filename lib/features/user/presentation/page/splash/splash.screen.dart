import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';
import 'package:hot_place/features/user/presentation/bloc/auth/auth.cubit.dart';

import '../../../../app/constant/route.constant.dart';

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
      // 인증된 경우 Home 페이지로, 인증되지 않은 경우 Welcome페이지로 이동
      final destination =
          context.read<AuthCubit>().state.status == AuthStatus.authenticated
              ? Routes.home.path
              : Routes.welcome.path;
      context.pushReplacement(destination);
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
