import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/presentation/bloc/auth/sign_in/cubit.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/generated/assets.gen.dart';
import '../../../../core/theme/theme.dart';

part 's_sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInCubit>(),
      child: const SignInScreen(),
    );
  }
}
