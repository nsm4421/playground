import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.bloc.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';
import 'package:my_app/presentation/pages/auth/sign-up/already_sign_up.screen.dart';
import 'package:my_app/presentation/pages/auth/sign-up/on_boarding.screen.dart';
import 'package:my_app/presentation/pages/auth/sign-up/sign_up_view.screen.dart';

import '../../../../core/constant/enums/sign_up.enum.dart';
import '../../../../dependency_injection.dart';
import 'auth_error.screen.dart';
import 'sign_up_complete.screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<SignUpBloc>(),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (_, state) {
            switch (state.status) {
              case SignUpStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case SignUpStatus.initial:
                return const SignUpViewScreen();
              case SignUpStatus.onBoarding:
                return const OnBoardingScreen();
              case SignUpStatus.alreadySignUp:
                return const AlreadySignUpScreen();
              case SignUpStatus.error:
                return const AuthErrorScreen();
              case SignUpStatus.done:
                return const SignUpCompleteScreen();
            }
          },
        ),
      );
}
