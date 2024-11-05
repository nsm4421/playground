import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/presentation/bloc/auth/presence/bloc.dart';
import 'package:travel/presentation/bloc/auth/sign_in/cubit.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/route/routes.dart';
import 'package:travel/presentation/widget/widget.dart';

part 's_sign_in.dart';

part 'f_form.dart';

part 'w_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BlocModule>().signIn,
      child: BlocListener<SignInCubit, SignInState>(
        listenWhen: (prev, curr) => prev.status == Status.loading,
        listener: (context, state) async {
          switch (state.status) {
            case Status.success:
              getIt<CustomSnackBar>().success(title: 'sign in success');
              context.read<AuthenticationBloc>().add(UpdateCurrentUserEvent());
              return;
            case Status.error:
              getIt<CustomSnackBar>().error(title: 'sign in fail');
              await Future.delayed(2.sec, () {
                context.read<SignInCubit>().init();
              });
            default:
          }
        },
        child: Stack(
          children: [
            BlocBuilder<SignInCubit, SignInState>(
              builder: (context, state) {
                return LoadingOverLayWidget(
                  isLoading: state.status == Status.loading,
                  loadingWidget: const CircularProgressIndicator(),
                  childWidget: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SignInScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
