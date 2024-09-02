import 'package:flutter/material.dart';
import 'package:flutter_app/auth/presentation/widgets/widgets.dart';
import 'package:flutter_app/shared/config/di/dependency_injection.dart';
import 'package:flutter_app/shared/style/style.dart';
import 'package:flutter_app/shared/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc.dart';

part 'sign_in.screen.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<LoginCubit>(), child: const SignInScreen());
  }
}
