import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/core/util/toast.util.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:my_app/presentation/components/user/avatar.widget.dart';

import '../../../../components/error.fragment.dart';
import '../../../../components/loading.fragment.dart';

part 'edit_profile.screen.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
        listenWhen: (prev, curr) =>
            (prev is UserLoadingState) && (curr is UserLoadedState),
        listener: (BuildContext context, UserState state) {
          if (context.mounted) {
            context.pop();
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (BuildContext context, UserState state) {
            if (state is UserLoadedState) {
              return const EditProfileScreen();
            }
            if (state is UserLoadingState) {
              return LoadingFragment();
            } else {
              return ErrorFragment();
            }
          },
        ));
  }
}
