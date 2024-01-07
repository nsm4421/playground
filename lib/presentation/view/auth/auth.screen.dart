import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/view/auth/sign_in.screen.dart';

import '../../../core/enums/status.enum.dart';
import '../../bloc/auth/user.bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.read<UserBloc>().state.status;
    switch (status) {
      case Status.initial:
      case Status.success:
        return const SignInScreen();
      case Status.loading:
        return const _OnLoading();
      case Status.error:
        return const _OnError();
    }
  }
}

class _OnError extends StatelessWidget {
  const _OnError({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text("ERROR"),
      );
}

class _OnLoading extends StatelessWidget {
  const _OnLoading({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
