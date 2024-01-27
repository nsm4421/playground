import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/main/main.screen.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.bloc.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';
import 'package:my_app/presentation/pages/auth/sign-up/on_boarding.screen.dart';
import 'package:my_app/presentation/pages/auth/sign-up/index.screen.dart';
import 'package:my_app/presentation/pages/auth/sign-up/sign_up_complete.screen.dart';

import '../../../core/constant/enums/routes.enum.dart';
import '../../../core/constant/enums/sign_up.enum.dart';
import '../../../dependency_injection.dart';
import 'sign-up/auth_error.screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<SignUpBloc>(),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (_, state) {
            switch (state.status) {
              // index 페이지
              case SignUpStatus.initial:
                return const IndexScreen();
              // On Boarding
              case SignUpStatus.onBoarding:
                return const OnBoardingScreen();
              // 회원가입 완료
              case SignUpStatus.done:
                return const SignUpCompleteScreen();
              // 로딩중
              case SignUpStatus.loading:
                return const Center(child: CircularProgressIndicator());
              // 오류
              case SignUpStatus.error:
                return const AuthErrorScreen();
            }
          },
        ),
      );
}
