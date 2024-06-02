import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/presentation/bloc/short/upload/upload_short.cubit.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';

import '../../../../../core/constant/status.dart';
import '../../../../bloc/short/upload/upload_short.state.dart';
import '../../../../components/video_preview/video_preview_for_upload.widget.dart';

part 'upload_short_view.fragment.dart';

class UploadShortScreen extends StatelessWidget {
  const UploadShortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<UploadShortCubit>(),
      child: BlocListener<UploadShortCubit, UploadShortState>(
        listener: (context, state) {
          if (state.status == Status.success && context.mounted) {
            context.pop();
          }
        },
        child: BlocBuilder<UploadShortCubit, UploadShortState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
              case Status.success:
                return const UploadShortViewFragment();
              case Status.loading:
                return const LoadingFragment();
              case Status.error:
                return const ErrorFragment();
            }
          },
        ),
      ),
    );
  }
}
