import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/auth/presentation/bloc/auth.bloc.dart';
import 'package:portfolio/features/auth/presentation/bloc/auth.state.dart';
import 'package:portfolio/features/common/presentation/components/loading.screen.dart';

import '../../../../../core/response/status.dart';

part "sign_up.screen.dart";

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state.status == Status.success && context.mounted) {
          // 회원가입 성공 시, 회원가입 화면 닫기
          context.pop();
        } else if (state.status == Status.error) {
          // 에러 발생 시, 2초 뒤 초기화면으로 이동
          Timer(const Duration(seconds: 2), () {
            context.read<AuthBloc>().add(InitAuthEvent());
          });
        }
      },
      child:
          BlocBuilder<AuthBloc, AuthenticationState>(builder: (context, state) {
        switch (state.status) {
          case Status.initial:
          case Status.success:
            return const SignUpScreen();
          // 로딩중, 에러인 경우 로딩중 화면
          case Status.loading:
          case Status.error:
            return const LoadingScreen();
        }
      }),
    );
  }
}
