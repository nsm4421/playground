import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/enums/route.enum.dart';
import 'package:my_app/core/enums/status.enum.dart';
import 'package:my_app/presentation/bloc/auth/user.bloc.dart';

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

    // after 2 sec, move to other page
    Future.delayed(const Duration(seconds: _durationSec), () {
      context.go(
          context.read<UserBloc>().state.authStatus == AuthStatus.authenticated
              ? RoutePath.main.path
              : RoutePath.signIn.path);
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('SPLASH PAGE'),
        ),
      );
}
