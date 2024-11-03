import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/presentation/bloc/auth/sign_in/cubit.dart';
import 'package:travel/presentation/widget/widget.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/theme/theme.dart';

part 's_sign_in.dart';

part 'f_form.dart';

part 'w_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInCubit>(),
      child: BlocListener<SignInCubit, SignInState>(
        listenWhen: (prev, curr) => prev.status == Status.loading,
        listener: (context, state) async {
          switch (state.status) {
            case Status.success:
              context.showCustomSnackBar(
                  type: SnackBarType.success,
                  shake: true,
                  duration: 1.sec,
                  title: 'sign in success');
            // TODO : 홈화면으로 이동
            case Status.error:
              context.showCustomSnackBar(
                  type: SnackBarType.error,
                  duration: 1.sec,
                  title: 'sign in fails');
            default:
          }
          Future.delayed(2.sec, () {
            context.read<SignInCubit>().init();
          });
        },
        child: BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            return Center(
                child: Container(
                    height: context.height * 2 / 3,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 18),
                    decoration: BoxDecoration(
                      color: CustomPalette.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: LoadingOverLayWidget(
                        isLoading: state.status == Status.loading,
                        loadingWidget: const CircularProgressIndicator(),
                        childWidget: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: SignInScreen(),
                        ))));
          },
        ),
      ),
    );
  }
}
