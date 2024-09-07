import 'package:flutter/material.dart';
import 'package:flutter_app/auth/presentation/bloc/authentication.bloc.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/sign_in_button.widget.dart';

part 'sign_in.screen.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const int _throttleDuration = 1; // 로그인 실패 시, 버튼이 active될 때까지 시간(초)

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case Status.success:
            getIt<CustomSnakbar>().success(title: '로그인 성공');
          case Status.error:
            getIt<CustomSnakbar>().error(
                title: '로그인 오류',
                description:
                    context.read<AuthenticationBloc>().state.errorMessage);
            Future.delayed(const Duration(seconds: _throttleDuration), () {
              context.read<AuthenticationBloc>().add(InitAuthEvent());
            });
          default:
            return;
        }
      },
      child: const SignInScreen(),
    );
  }
}
