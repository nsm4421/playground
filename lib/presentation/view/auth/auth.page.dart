import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/util/util.dart';

import '../../../core/constant/constant.dart';
import '../../bloc/auth/authentication.bloc.dart';
import '../../route/router.dart';
import '../../widgets/widgets.dart';

part 'sign_in/sign_in.screen.dart';

part 'sign_up/sign_up.screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (BuildContext context, AuthenticationState state) {
      if (state.step == AuthenticationStep.authorized) {
        // 인증된 경우 홈화면으로
        context.go(Routes.home.path);
      } else if (state.status == Status.error) {
        // 에러가 발생한 경우, 에러메세지를 띄우고, 0.5초 뒤 원래 상태로 복구
        customUtil.showErrorSnackBar(
            context: context, message: state.errorMessage);
        Timer(const Duration(milliseconds: 500), () {
          context
              .read<AuthenticationBloc>()
              .add(InitializeEvent(status: Status.initial, errorMessage: ''));
        });
      }
    }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
      return LoadingOverLayScreen(
          isLoading: state.status == Status.loading,
          loadingWidget: const CircularProgressIndicator(),
          childWidget: switch (state.step) {
            AuthenticationStep.signUp => const SignUpScreen(),
            AuthenticationStep.signIn => const SignInScreen(),
            AuthenticationStep.authorized => const PageNotFounded(),
          });
    }));
  }
}
