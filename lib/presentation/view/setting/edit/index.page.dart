import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';
import '../../../../domain/entity/auth/presence.dart';
import '../../../bloc/auth/authentication.bloc.dart';
import '../../../route/router.dart';
import '../../../widgets/widgets.dart';

part 'edit_profile.screen.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case Status.success:
            context.go(Routes.setting.path);
            customUtil.showErrorSnackBar(
                context: context, message: 'profile is edited');
            return;
          case Status.error:
            customUtil.logger.e(state.errorMessage);
            Timer(const Duration(seconds: 1), () {
              customUtil.showErrorSnackBar(
                  context: context, message: state.errorMessage);
              context.read<AuthenticationBloc>().add(
                  InitializeEvent(status: Status.initial, errorMessage: ''));
            });
            return;
          default:
            return;
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        return LoadingOverLayScreen(
            isLoading: (state.status == Status.loading),
            loadingWidget: const Center(child: CircularProgressIndicator()),
            childWidget: const EditProfileScreen());
      }),
    );
  }
}
