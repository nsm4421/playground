import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_app/shared/shared.export.dart';

import '../../blocs/sign_up/sign_up.cubit.dart';

part 'sign_up.screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const int _throttleDuration = 1; // 로그인 실패 시, 버튼이 active될 때까지 시간(초)

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<SignUpCubit>(),
        child: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              switch (state.status) {
                case SignUpStatus.success:
                  getIt<CustomSnakbar>().success(title: '회원가입 성공');
                  context.pushReplacement(RoutePaths.auth.path);
                case SignUpStatus.dupliacatedUsername:
                case SignUpStatus.invalidParameter:
                case SignUpStatus.weakPassword:
                case SignUpStatus.alreadyExistEmail:
                case SignUpStatus.error:
                  getIt<CustomSnakbar>().error(
                      title: '회원가입 오류',
                      description:
                          context.read<SignUpCubit>().state.errorMessage);
                  Future.delayed(const Duration(seconds: _throttleDuration),
                      () {
                    context.read<SignUpCubit>().reset();
                  });
                default:
                  return;
              }
            },
            child: const SignUpScreen()));
  }
}
