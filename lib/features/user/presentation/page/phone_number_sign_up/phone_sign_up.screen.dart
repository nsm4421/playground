import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';
import 'package:hot_place/features/app/theme/custom_palette.theme.dart';
import 'package:hot_place/features/user/presentation/bloc/phone_sign_up/sign_up.bloc.dart';
import 'package:hot_place/features/user/presentation/page/phone_number_sign_up/on_boarding.fragment.dart';
import 'package:hot_place/features/user/presentation/page/phone_number_sign_up/phone_number.fragment.dart';

import '../../../../app/dependency_injection/dependency_injection.dart';
import '../../bloc/phone_sign_up/sign_up.event.dart';
import '../../bloc/phone_sign_up/sign_up.state.dart';
import 'otp.fragment.dart';

class PhoneSignUpScreen extends StatelessWidget {
  const PhoneSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => getIt<SignUpBloc>()..add(SignUpInit()),
      child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (BuildContext context, SignUpState state) => Scaffold(
                appBar: _Appbar(state),
                body: _Body(state),
              )));
}

class _Appbar extends StatelessWidget implements PreferredSizeWidget {
  const _Appbar(this.state);

  final SignUpState state;

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(
          state.step.label,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: CustomPalette.appBarTextColor),
        ),
        centerTitle: true,
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Body extends StatelessWidget {
  const _Body(this.state);

  final SignUpState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    switch (state.step) {
      case SignUpStep.initial:
      case SignUpStep.phoneNumber:
        return const PhoneNumberFragment();
      case SignUpStep.otp:
        return const OtpFragment();
      case SignUpStep.onBoarding:
        return const OnBoardingFragment();
      default:
        return const Text("ERROR");
    }
  }
}
