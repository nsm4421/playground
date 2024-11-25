import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/domain/entity/auth/presence.dart';
import 'package:travel/presentation/bloc/auth/edit_profile/cubit.dart';
import 'package:travel/presentation/bloc/auth/presence/bloc.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/widget/widget.dart';

part 's_profile.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlocModule>()
          .editProfile(context.read<AuthenticationBloc>().state.currentUser!),
      child: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) async {
          if (state.status == Status.success) {
            context.read<AuthenticationBloc>().add(UpdateCurrentUserEvent());
            await Future.delayed(500.ms, () {
              context.pop();
            });
          } else if (state.status == Status.error) {
            getIt<CustomSnackBar>()
                .error(title: 'Error', description: state.message);
            await Future.delayed(200.ms, () {
              context
                  .read<EditProfileCubit>()
                  .init(status: Status.initial, message: '');
            });
          }
        },
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            return LoadingOverLayWidget(
                isLoading: state.status == Status.loading ||
                    state.status == Status.success,
                loadingWidget: const Center(child: CircularProgressIndicator()),
                childWidget: const EditProfileScreen());
          },
        ),
      ),
    );
  }
}
