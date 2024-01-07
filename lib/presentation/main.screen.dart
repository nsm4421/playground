import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/config/dependency_injection.dart';
import 'package:my_app/presentation/bloc/auth/user.bloc.dart';
import 'package:my_app/presentation/bloc/auth/user.state.dart';

import '../core/enums/status.enum.dart';
import 'bloc/auth/user.event.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => getIt<UserBloc>()..add(InitialAuthCheck()),
      child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            final status = state.authStatus;
            switch (status) {
              case AuthStatus.initial:
              case AuthStatus.unAuthenticated:
                context.go('/main');
              case AuthStatus.authenticated:
                context.go('/auth');
            }
          },
          builder: (_, __) => const Scaffold(
              body: Center(child: CircularProgressIndicator()))));
}
