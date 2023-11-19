import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/asset_path.dart';
import 'bloc/sign_up.bloc.dart';
import 'bloc/sign_up.event.dart';

class SignUpViewScreen extends StatelessWidget {
  const SignUpViewScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "회원가입",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            elevation: 0),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                _GoogleSignUpButton(),
              ],
            ),
          ),
        ),
      );
}

class _GoogleSignUpButton extends StatefulWidget {
  const _GoogleSignUpButton({super.key});

  @override
  State<_GoogleSignUpButton> createState() => _GoogleSignUpButtonState();
}

class _GoogleSignUpButtonState extends State<_GoogleSignUpButton> {
  _handleSignUp() => context.read<SignUpBloc>().add(GoogleSignUpEvent());

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: _handleSignUp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetPath.googleLogo),
          const SizedBox(width: 10),
          Text("Google 회원가입",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700))
        ],
      ));
}
