import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/core/util/toast.util.dart';
import 'package:my_app/presentation/bloc/feed/upload/upload_feed.cubit.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/constant/dto.constant.dart';
import '../../../../../core/constant/status.dart';
import '../../../../bloc/feed/feed.bloc.dart';
import '../../../../bloc/feed/upload/upload_feed.state.dart';

part 'select_file.fragment.dart';

part 'upload_feed.screen.dart';

part 'media_preview.widget.dart';

class UploadFeedPage extends StatelessWidget {
  const UploadFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FeedBloc>().upload,
      child: BlocListener<UploadFeedCubit, UploadFeedState>(
        listener: (context, state) {
          if (state.status == Status.success && context.mounted) {
            context.pop();
          }
        },
        child: BlocBuilder<UploadFeedCubit, UploadFeedState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
              case Status.success:
                return const UploadFeedScreen();
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
