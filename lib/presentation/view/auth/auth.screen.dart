import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return _AuthScreenView();
      case Status.loading:
        return _OnLoading();
      case Status.error:
        return _OnError();
    }
  }
}

class _AuthScreenView extends StatelessWidget {
  const _AuthScreenView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(),
        ),
      );
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
