import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/auth/cubit/auth.cubit.dart';
import 'package:hot_place/presentation/auth/bloc/sign_up.bloc.dart';
import 'package:hot_place/presentation/auth/bloc/sign_up.event.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  handleGoogleSignIn(BuildContext context) => () {
        context.read<SignUpBloc>().add(GoogleSignUpEvent());
        context.read<AuthCubit>().startApp();
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
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().logout();
                  },
                  child: Center(
                    child: Text(
                      "Sign Out",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint(context.read<AuthCubit>().state.toString());
                  },
                  child: Center(
                    child: Text(
                      "TEST",
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
