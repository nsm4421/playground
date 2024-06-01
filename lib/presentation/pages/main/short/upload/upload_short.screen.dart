import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/presentation/bloc/short/upload/upload_short.cubit.dart';

import '../../../../../core/constant/status.dart';
import '../../../../bloc/short/upload/upload_short.state.dart';
import '../../../../components/video_player.widget.dart';

part 'upload_short_view.widget.dart';

part 'upload_short_loading.widget.dart';

part 'upload_short_error.widget.dart';

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
                return const UploadShortViewWidget();
              case Status.loading:
                return UploadShortLoadingWidget(state);
              case Status.error:
                return const UploadShortErrorWidget();
            }
          },
        ),
      ),
    );
  }
}
