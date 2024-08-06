import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/core/constant/status.dart';
import 'package:portfolio/domain/entity/auth/account.entity.dart';
import 'package:portfolio/presentation/bloc/auth/auth.bloc.dart';
import 'package:portfolio/presentation/bloc/auth/auth.state.dart';
import 'package:portfolio/presentation/pages/main/components/error.screen.dart';
import 'package:portfolio/presentation/pages/main/components/loading.screen.dart';

part "edit_profile.screen.dart";

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final account =
        AccountEntity.fromUser(context.read<AuthBloc>().currentUser!);
    return BlocListener<AuthBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state.status == Status.success && context.mounted) {
          Timer(const Duration(seconds: 2), () {
            Fluttertoast.showToast(msg: 'success');
            context.pop();
          });
        } else if (state.status == Status.error) {
          Timer(const Duration(seconds: 2), () {
            Fluttertoast.showToast(msg: state.message ?? 'error');
            context.read<AuthBloc>().add(InitAuthEvent());
          });
        }
      },
      child:
          BlocBuilder<AuthBloc, AuthenticationState>(builder: (context, state) {
        switch (state.status) {
          case Status.initial:
            return EditProfileScreen(account);
          case Status.loading:
          case Status.success:
            return const LoadingScreen();
          case Status.error:
            return const ErrorScreen();
        }
      }),
    );
  }
}
