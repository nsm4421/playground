import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/config/dependency_injection.dart';
import 'package:my_app/core/enums/route.enum.dart';
import 'package:my_app/presentation/bloc/auth/user.bloc.dart';
import 'package:my_app/presentation/bloc/auth/user.state.dart';

import '../../../core/enums/status.enum.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        final status = state.authStatus;
        switch (status) {
          // not login
          case AuthStatus.initial:
          case AuthStatus.unAuthenticated:
            context.go(RoutePath.auth.path);

          // login
          case AuthStatus.authenticated:
            context.go(RoutePath.home.path);
        }
      },
      builder: (_, __) =>
          const Scaffold(body: Center(child: CircularProgressIndicator())));
}
