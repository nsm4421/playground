import 'package:flutter/material.dart';
import 'package:flutter_app/shared/config/di/dependency_injection.dart';
import 'package:flutter_app/shared/style/style.export.dart';
import 'package:flutter_app/shared/widgets/widgets.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/sign_in/sign_in.cubit.dart';
import '../../widgets/sign_in_button.widget.dart';

part 'sign_in.screen.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<SignInCubit>(), child: const SignInScreen());
  }
}
