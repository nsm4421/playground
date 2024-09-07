import 'package:flutter/material.dart';
import 'package:flutter_app/auth/presentation/blocs/auth/authentication.bloc.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/sign_in/sign_in.cubit.dart';
import '../../widgets/sign_in_button.widget.dart';

part 'sign_in.screen.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const int _throttleDuration = 1; // 로그인 실패 시, 버튼이 active될 때까지 시간(초)

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<SignInCubit>(),
        child: BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            switch (state.status) {
              case SignInStatus.success:
                getIt<CustomSnakbar>().success(title: '로그인 성공');
              case SignInStatus.invalidParameter:
              case SignInStatus.userNotFound:
              case SignInStatus.wrongPassword:
              case SignInStatus.error:
                getIt<CustomSnakbar>().error(
                    title: '로그인 오류',
                    description:
                        context.read<SignInCubit>().state.errorMessage);
                Future.delayed(const Duration(seconds: _throttleDuration), () {
                  context.read<SignInCubit>().reset();
                });
              default:
                return;
            }
          },
          child: const SignInScreen(),
        ));
  }
}
