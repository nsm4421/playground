import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/features/auth/presentation/bloc/auth.bloc.dart';
import 'package:portfolio/features/auth/presentation/bloc/auth.state.dart';

import '../../../../main/core/constant/status.dart';
import '../../../../main/presentation/components/loading.screen.dart';

part "sign_up.screen.dart";

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state.status == Status.success) {
          // 회원가입 성공 시
          Fluttertoast.showToast(
              msg: "Sign Up Success", gravity: ToastGravity.TOP);
          context.read<AuthBloc>().add(InitAuthEvent());
          context.pop();
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
