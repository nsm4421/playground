import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/enums/route.enum.dart';
import 'package:my_app/core/enums/status.enum.dart';
import 'package:my_app/presentation/bloc/auth/auth.bloc.dart';

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

    // 2초 뒤
    Future.delayed(const Duration(seconds: _durationSec), () {
      context.go(
          context.read<AuthBloc>().state.authStatus == AuthStatus.authenticated
              ? RoutePath.main.path
              : RoutePath.signIn.path);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Text('Karma', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 30),
            Text('환영합니다', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      );
}
