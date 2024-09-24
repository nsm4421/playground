import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/auth/auth.export.dart';
import 'package:flutter_app/auth/domain/domain.export.dart';
import 'package:flutter_app/setting/presentation/bloc/edit_profile/edit_profile.cubit.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'edit_profile.screen.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<EditProfileCubit>(),
        child: BlocListener<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state.isUploading && state.status == Status.success) {
              // 프로필 수정 성공 시
              Timer(const Duration(seconds: 1), () {
                context.read<EditProfileCubit>().init(status: Status.initial);
                context.read<AuthenticationBloc>().add(UpdateProfileEvent());
                getIt<CustomSnakbar>().success(title: '프로필이 수정되었습니다');
                context.pop();
              });
            } else if (state.status == Status.error) {
              // 프로필 수정 중 오류 발생 시
              Timer(const Duration(seconds: 1), () {
                context.read<EditProfileCubit>().init(status: Status.initial);
                if (state.isUploading) {
                  getIt<CustomSnakbar>()
                      .error(title: state.errorMessage ?? '알수 없는 오류가 발생했습니다');
                }
              });
            }
          },
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
            return state.isUploading
                ? const Center(child: CircularProgressIndicator())
                : const EditProfileScreen();
          }),
        ));
  }
}
