import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/main/bloc/auth/auth.bloc.dart';
import 'package:hot_place/presentation/main/bloc/auth/auth.event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  handleGoogleSignIn(BuildContext context) =>
      () => context.read<AuthBloc>().add(GoogleSignInEvent());

  // TODO : 이메일, 비밀번호 인증화면 만들기
  handleSignUpWithEmailAndPassword(BuildContext context) => () {
        context.read<AuthBloc>().add(SignUpWithEmailAndPasswordEvent(
            email: 'test1@naver.com', password: '1q2w3e4r!!'));
      };

  handleSignInWithEmailAndPassword(BuildContext context) => () {
        context.read<AuthBloc>().add(SignInWithEmailAndPasswordEvent(
            email: 'test1@naver.com', password: '1q2w3e4r!!'));
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 25),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                  thickness: 1,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: handleGoogleSignIn(context),
                  child: Center(
                    child: Text(
                      "Google 계정으로 로그인하기",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                  thickness: 1,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: handleSignUpWithEmailAndPassword(context),
                  child: Center(
                    child: Text(
                      "이메일,비밀번호 회원가입하기",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: handleSignInWithEmailAndPassword(context),
                  child: Center(
                    child: Text(
                      "이메일,비밀번호 로그인하기",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
