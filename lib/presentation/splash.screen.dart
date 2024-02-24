import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/constant/user.constant.dart';
import 'package:hot_place/presentation/auth/cubit/auth.cubit.dart';

import '../core/constant/route.constant.dart';

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
              : Routes.login.path;
      context.pushReplacement(destination);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hot Place",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      );
}
