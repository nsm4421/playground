import 'package:flutter/material.dart';
import 'package:flutter_app/auth/auth.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/style/style.export.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

// TODO : 구글 로그인 기능 구현하기
  _handleSignIn() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ElevatedButton(
            onPressed: _handleSignIn,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.google.svg(
                  height: CustomTextSize.xl,
                ),
                CustomWidth.xl,
                const Text('구글 계정으로 로그인하기'),
              ],
            ));
      },
    );
  }
}

class GithubSignInButton extends StatelessWidget {
  const GithubSignInButton({super.key});

// TODO : 깃허브 로그인 기능 구현하기
  _handleSignIn() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return ElevatedButton(
          onPressed: _handleSignIn,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.github
                  .svg(height: CustomTextSize.xl, color: Colors.white),
              CustomWidth.xl,
              const Text('깃허브 계정으로 로그인하기'),
            ],
          ));
    });
  }
}
