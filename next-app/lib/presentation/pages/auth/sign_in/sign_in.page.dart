import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/presentation/bloc/auth/auth.bloc.dart';
import 'package:portfolio/presentation/bloc/auth/auth.state.dart';

import '../../../../core/constant/status.dart';
import '../../../../core/route/router.dart';
import '../../main/components/loading.screen.dart';

part "sign_in.screen.dart";

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthenticationState>(
      listener: (_, state) {
        if (state.status == Status.success) {
          Fluttertoast.showToast(
              msg: "Login Success", gravity: ToastGravity.TOP);
        } else if (state.status == Status.error) {
          // 에러 발생 시, 2초 뒤 초기화면으로 이동
          Timer(const Duration(seconds: 2), () {
            Fluttertoast.showToast(
                msg: state.message ?? "error occurs",
                gravity: ToastGravity.TOP);
            context.read<AuthBloc>().add(InitAuthEvent());
          });
        }
      },
      child: BlocBuilder<AuthBloc, AuthenticationState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.initial:
            case Status.success:
              return const SignInScreen();
            case Status.loading:
            case Status.error:
              return const LoadingScreen();
          }
        },
      ),
    );
  }
}
