import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/response/error_response.dart';
import 'package:my_app/presentation/view/auth/sign_in.screen.dart';

import '../../../core/enums/route.enum.dart';
import '../../../core/enums/status.enum.dart';
import '../../bloc/auth/auth.bloc.dart';
import '../../bloc/auth/auth.state.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state.authStatus == AuthStatus.authenticated) {
            context.go(RoutePath.main.path);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (_, state) {
            switch (state.status) {
              case Status.initial:
              case Status.success:
                return const SignInScreen();
              case Status.loading:
                return const _OnLoading();
              case Status.error:
                return _OnError(state.error);
            }
          },
        ),
      );
}

class _OnError extends StatelessWidget {
  const _OnError(this.error, {super.key});

  final ErrorResponse error;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(elevation: 0),
        body: Center(
          child: Column(
            children: [
              const Text("에러가 발생했습니다"),
              const SizedBox(height: 30),
              Text(
                error.message ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
            ],
          ),
        ),
      );
}

class _OnLoading extends StatelessWidget {
  const _OnLoading({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
