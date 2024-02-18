import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';
import 'package:hot_place/features/user/presentation/view/page/sign_up/on_boarding.screen.dart';
import 'package:hot_place/features/user/presentation/view/page/sign_up/otp.screen.dart';
import 'package:hot_place/features/user/presentation/view/page/sign_up/phone_number.screen.dart';
import 'package:hot_place/features/user/presentation/view/page/sign_up/sign_init.screen.dart';

import '../../../../../app/dependency_injection/dependency_injection.dart';
import '../../../bloc/cubit/sign_up/sign_up.cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => getIt<SignUpCubit>(),
      child: BlocBuilder<SignUpCubit, SignUpStep>(
          builder: (BuildContext context, SignUpStep step) {
        switch (step) {
          case SignUpStep.initial:
            return const SignUpInit();
          case SignUpStep.phoneNumber:
            return const PhoneNumberScreen();
          case SignUpStep.otp:
            return const OtpScreen();
          case SignUpStep.onBoarding:
            return const OnBoardingScreen();
          default:
            return const Text("ERROR");
        }
      }));
}
