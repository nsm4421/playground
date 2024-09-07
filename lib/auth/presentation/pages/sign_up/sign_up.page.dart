import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/auth/auth.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_app/shared/shared.export.dart';

part 'sign_up.screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const int _throttleDuration = 1; // 로그인 실패 시, 버튼이 active될 때까지 시간(초)

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case Status.success:
              getIt<CustomSnakbar>().success(title: '회원가입 성공');
              context.pushReplacement(RoutePaths.auth.path);
            case Status.error:
              getIt<CustomSnakbar>().error(
                  title: '회원가입 오류',
                  description:
                      context.read<AuthenticationBloc>().state.errorMessage);
              Future.delayed(const Duration(seconds: _throttleDuration), () {
                context.read<AuthenticationBloc>().add(InitAuthEvent());
              });
            default:
              return;
          }
        },
        child: const SignUpScreen());
  }
}
